#!/bin/bash

err() {
    # Since this is called from Sway, I want the help text to be displayed where I notice it
    notify-send --icon com.mitchellh.ghostty "$@"
    exit 1
}

command -v jq &>/dev/null || err "Error: jq is required to run ${BASH_SOURCE[0]}"

ICON_THEME="Papirus-Dark"
ICON_SIZE="32x32"

# Get the list of open windows
windows=$(swaymsg -t get_tree | jq -r '.. | try select(.type == "con" and .name != null) | "\(.app_id) \(.name)"')

formatted_windows=""

# Process each window entry
while IFS= read -r window; do
    app_id=$(echo "$window" | awk '{print $1}')
    name=${window#"$app_id "}

    # Find the icon path
    icon_path=$(fd "$app_id" /usr/share/icons/*/$ICON_SIZE | head -n 1)

    # Use a default icon if no specific icon is found
    if [[ -z "$icon_path" || "$app_id" == "null" ]]; then
        icon_path="/usr/share/icons/$ICON_THEME/$ICON_SIZE/apps/application-default-icon.svg"
    fi

    # Format the window entry with icon
    if [[ "$app_id" == "null" ]]; then
        formatted_windows+="$name\x00icon\x1f$icon_path\n"
    else
        formatted_windows+="$app_id\x00icon\x1f$icon_path\n"
    fi

done <<<"$windows"

# Use fuzzel to select a window
selection=$(echo -e "$formatted_windows" | fuzzel --dmenu)

# Focus the selected window
[ -n "$selection" ] && swaymsg "[title=\"$selection\"] focus"
