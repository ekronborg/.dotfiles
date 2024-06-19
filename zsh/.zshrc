# Source global definitions (if any)
if [[ -f /etc/zshrc ]]; then
    . /etc/zshrc
elif [[ -f /etc/zsh/zshrc ]]; then
    . /etc/zsh/zshrc
fi

# https://zsh.sourceforge.io/Guide/zshguide02.html#l24
# https://wiki.archlinux.org/title/Zsh#Configuring_$PATH
typeset -U path PATH
path=(
    $HOME/.local/bin
    $HOME/.local/share/cargo/bin
    $path
)
export PATH

# Check if running under X11
if [[ -z "$WAYLAND_DISPLAY" ]]; then
    export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
    export XAUTHORITY="${XDG_RUNTIME_DIR:-/run/user/$UID}/Xauthority"
fi

# Set options (https://zsh.sourceforge.io/Doc/Release/Options.html)
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt EXTENDED_GLOB             # Treat the '#', '~' and '^' characters as active globbing pattern characters.
setopt PROMPT_SUBST              # Needed to for Git branch in prompt.

# Set up search history
# See https://www.reddit.com/r/zsh/comments/x7uj9e/measuring_the_best_value_of_histsize/
# See https://zsh.sourceforge.io/FAQ/zshfaq03.html#l39
# - $HISTFILE tells it where to write the history
# - $HISTSIZE tells the shell how many lines to keep internally
# - $SAVEHIST tells it how many to write out
# The simplest possibility is to set $SAVEHIST =  $HISTSIZE.
if [[ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history" ]]; then
    mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
    touch "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
fi

HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

# Colors
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
autoload -U colors && colors
autoload -Uz colors && colors
[[ "$COLORTERM" == (24bit|truecolor) || "${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor

# Completion menu
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
_comp_options+=(globdots)

# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' formats " (%b)"
PROMPT='%B%F{#ebddb2}%~%f%F{#928374}${vcs_info_msg_0_}%f %F{#8ec07c}➜%f%b '

# zsh-syntax-highlighting must be sourced last
source $HOME/.config/zsh/vim-mode.zsh
source $HOME/.config/shell/functions/diff
source $HOME/.config/shell/aliases
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
