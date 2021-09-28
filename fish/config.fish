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
        # set_color purple --bold
        set_color "#8ec07c" --bold
        printf " %s" (prompt_long_pwd)
        set_color normal
        printf "] "
        # printf "%s " (__fish_git_prompt)
        set_color normal
end

# Using exa for more colors
# set -Ua fish_user_paths $HOME/.cargo/bin
alias ls='exa -al --color=always --group-directories-first'
