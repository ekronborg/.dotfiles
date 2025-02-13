#!/bin/bash

_usage="
Usage: $0 [OPTION]

Options:
    -h, --help      display this text and exit
    -c, --check     check for pending updates
    -n, --notify    notify about pending updates
"

err() {
    echo "$@" >&2
    # Since this is called from Waybar, I want the help text to be displayed where I notice it
    notify-send "$_usage"
    exit 1
}

check_updates() {
    if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
        updates_arch=0
    fi

    if ! updates_aur=$(paru -Qum 2>/dev/null | wc -l); then
        updates_aur=0
    fi

    updates=$((updates_arch + updates_aur))

    echo "$updates"
}

send_notification() {
    if [ "$(check_updates)" -eq 0 ]; then
        notify-send --icon=/dev/null "System is up to date"
    else
        updates_list=""
        updates_list+=$(checkupdates 2>/dev/null)'\n'
        updates_list+=$(paru -Qum 2>/dev/null)
        notify-send --icon=/dev/null "$(echo -e "$updates_list")"
    fi
}

case "$1" in
-h | --help)
    echo "$_usage"
    ;;
-c | --check)
    check_updates
    ;;
-n | --notify)
    send_notification
    ;;
*)
    err "Invalid or missing option: try '$0 --help for more information'"
    ;;
esac
