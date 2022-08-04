# Add to path
export PATH=$HOME/.local/bin:$PATH

# System settings
export TERM="xterm-256color"
export COLORTERM="truecolor"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
# export MANPAGER="nvim +Man!"
# export MANPAGER="nvim +Man! -c 'set laststatus=0'"
export MANPAGER="nvim +Man! -c 'set laststatus=0 noruler nocursorline'"
export TERMINAL="alacritty"
export BROWSER="firefox"
export BAT_THEME="gruvbox-dark"

# Set XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$UID"

# Clean up $HOME (see https://github.com/b3nj5m1n/xdg-ninja)
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/pythonrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
export LESSHISTFILE="-"

# Fix for using Java applications with WMs
export _JAVA_AWT_WM_NONREPARENTING=1

# # Colored man pages
# export LESS=-R
# export LESS_TERMCAP_mb=$'\e[1;31m'
# export LESS_TERMCAP_md=$'\e[1;36m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;44;30m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;35m'
# export LESS_TERMCAP_ue=$'\e[0m'
