# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions (if any)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
elif [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Check if running under X11
if [[ -z "$WAYLAND_DISPLAY" ]]; then
    export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
    export XAUTHORITY="${XDG_RUNTIME_DIR:-/run/user/$UID}/Xauthority"
fi

# Add to path
export PATH=$HOME/.local/bin:$PATH

# Environment variables
source $HOME/.config/shell/env

# History settings
export HISTCONTROL="erasedups:ignorespace"

if [[ ! -f $HOME/.cache/bash/history ]]; then
    mkdir -p "$HOME"/.cache/bash
    touch "$HOME"/.cache/bash/history
fi

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/history"
HISTSIZE=10000000
SAVEHIST=10000000

# Bash shell options
shopt -s histappend
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
set -o vi
bind -m vi-insert "\C-l":clear-screen

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colors (00 means normal, 01 means bold)
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
RESET="\[\e[00m\]"
RED="\[\e[00;31m\]"
GREEN="\[\e[00;32m\]"
YELLOW="\[\e[00;33m\]"
BLUE="\[\e[00;34m\]"
PURPLE="\[\e[00;35m\]"
CYAN="\[\e[00;36m\]"

# Get current Git branch (https://stackoverflow.com/questions/4133904/ps1-line-with-git-current-branch-and-colors)
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set PS1 prompt (https://unix.stackexchange.com/questions/140610/using-variables-to-store-terminal-color-codes-for-ps1)
PS1="${RESET}[\u@\h ${CYAN}\w${BLUE}\$(parse_git_branch)${RESET}]\$ "

# Always use git diff
source $HOME/.config/shell/functions/diff

# Aliases
source $HOME/.config/shell/aliases
alias ls='ls --color=always --group-directories-first --sort=version'
alias ll='ls -lh'
alias la='ls -lAh'
