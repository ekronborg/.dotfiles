# Add to path
export PATH=$HOME/.local/bin:$PATH

# System settings
export BAT_THEME="ansi-dark" # Debian
# export BAT_THEME="gruvbox" # other distros
# export TERM=xterm-256color
# export COLORTERM="truecolor"

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"

# Set XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Clean up $HOME
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export LESSHISTFILE="-"
# export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"

# Colored man pages
export LESS=-R
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;30m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;35m'
export LESS_TERMCAP_ue=$'\e[0m'
