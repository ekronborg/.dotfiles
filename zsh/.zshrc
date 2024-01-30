# Source global definitions (if any)
# if [[ -f /etc/zshrc ]]; then
#     . /etc/zshrc
# elif [[ -f /etc/zsh/zshrc ]]; then
#     . /etc/zsh/zshrc
# fi

# https://zsh.sourceforge.io/Guide/zshguide02.html#l24
# https://wiki.archlinux.org/title/Zsh#Configuring_$PATH
typeset -U path PATH
path=($HOME/.local/bin $path)
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
setopt AUTO_RESUME

# Set up search history
# See https://www.reddit.com/r/zsh/comments/x7uj9e/measuring_the_best_value_of_histsize/
# See https://zsh.sourceforge.io/FAQ/zshfaq03.html#l39
# - $HISTFILE tells it where to write the history
# - $HISTSIZE tells the shell how many lines to keep internally
# - $SAVEHIST tells it how many to write out
# The simplest possibility is to set $SAVEHIST =  $HISTSIZE.
if [[ ! -f $HOME/.cache/zsh/history ]]; then
    mkdir -p "$HOME"/.cache/zsh
    touch "$HOME"/.cache/zsh/history
fi

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

# Enable Vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^R' history-incremental-pattern-search-backward
bindkey -a "^[[3~" delete-char
bindkey -v "^[[3~" delete-char
bindkey -v '^?' backward-delete-char

# Colors
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
autoload -U colors && colors

# Completion menu
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
_comp_options+=(globdots)

# FZF
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Generate prompt (https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Visual-effects)
# TIP: for colors in Vim, check `:hi comment`, for example
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# PROMPT='%B%F{#8ec07c}%~%f%F{#83a598}$(parse_git_branch)%f ➜%b '
PROMPT='%B%F{#ebddb2}%~%f%F{#928374}$(parse_git_branch)%f %F{#8ec07c}➜%f%b '

# Always use git diff
source $HOME/.config/shell/functions/diff

# Aliases
source $HOME/.config/shell/aliases

# Source plugins (remember to update the repositories once in a while)
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"
bindkey '^ ' autosuggest-accept

source $HOME/.config/zsh/plugins/zsh-syntax-highlightning/zsh-syntax-highlighting.zsh
# (( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[path]=none
# ZSH_HIGHLIGHT_STYLES[path_prefix]=none
