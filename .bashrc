# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source global definitions (if any)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Add cargo/bin to path for exa alias
PATH="$HOME/.cargo/bin${PATH:+:${PATH}}"

# Environment variables
export TERM=xterm-256color
export EDITOR=vim
export VISUAL=vim

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000

# Bash shell options
shopt -s histappend
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
set -o vi

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;35m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4m'

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set PS1 variable
source $HOME/git-prompt.sh
PS1='[\u@\h \[\033[1;96m\]\w\[\033[00m\]$(__git_ps1 " (%s)")]\$ ' 

# Aliases
alias ls='exa -al --color=always --group-directories-first'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'
alias up='sudo apt-get update && sudo apt-get upgrade -y'

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
