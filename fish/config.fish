# https://github.com/gruvbox-community/gruvbox/wiki/Terminal-Specific#a-256-color-gruvbox-palette-shellscript
bash "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

# [username@hostname PWD] settings
# https://stackoverflow.com/questions/866989/fish-interactive-shell-full-path
function fish_prompt
        set_color normal
        printf "["
        printf "%s" "$USER"
        printf "@"
        printf "%s" "$hostname"
        set_color "#8ec07c" --bold
        printf " %s" (prompt_long_pwd)
        set_color normal
        printf "] "
        set_color normal
end

# Using exa for more colors
alias ls='exa -al --color=always --group-directories-first'

# Set vim as default editor
set -gx EDITOR vim
