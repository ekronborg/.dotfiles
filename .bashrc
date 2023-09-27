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

# Add stuff to path
export PATH="$HOME/.local/bin:$PATH"

# Environment variables
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=vim

# History settings
HISTCONTROL=ignoreboth

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

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colors (00 means normal, 01 means bold)
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

# Aliases
alias ll='exa -al --color=always --group-directories-first'
alias lt='exa -al --tree --level=2 --color=always --group-directories-first'
alias dir='dir --color=always'
alias vdir='vdir --color=always'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'
alias ip='ip --color=always'
bind -m vi-insert "\C-l":clear-screen

# Handy extract program
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1                  ;;
            *.tar.gz)    tar xvzf $1                  ;;
            *.bz2)       bunzip2 $1                   ;;
            *.rar)       unrar x $1                   ;;
            *.gz)        gunzip $1                    ;;
            *.tar)       tar xvf $1                   ;;
            *.tbz2)      tar xvjf $1                  ;;
            *.tgz)       tar xvzf $1                  ;;
            *.zip)       unzip $1                     ;;
            *.Z)         uncompress $1                ;;
            *.7z)        7z x $1                      ;;
            *)           echo "can't extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
