# [username@hostname PWD (git)]
function fish_prompt
        set_color normal
        printf "["
        printf "%s" "$USER"
        printf "@"
        printf "%s" "$hostname"
        set_color "#8ec07c" --bold
        printf " %s" (prompt_long_pwd)
        set_color normal
        printf "%s" (fish_git_prompt)
        printf "]\$ "
        set_color normal
end

# Set vim as default editor
set -gx EDITOR vim

# Add color to man pages
set -xU LESS_TERMCAP_mb (printf "\e[01;35m")
set -xU LESS_TERMCAP_md (printf "\e[01;36m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;34m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[04m")
