# Source global definitions (if any)
# if [[ -f /etc/zshrc ]]; then
#     . /etc/zshrc
# elif [[ -f /etc/zsh/zshrc ]]; then
#     . /etc/zsh/zshrc
# fi

# Set options (https://zsh.sourceforge.io/Doc/Release/Options.html)
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
setopt extended_glob
setopt prompt_subst
setopt auto_resume

# Set up search history
HISTFILE=~/.cache/zsh/history
HISTSIZE=50000
SAVEHIST=10000

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

# Aliases
source $HOME/.config/zsh/aliases

# Source plugins (remember to update the repositories once in a while)
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"
bindkey '^ ' autosuggest-accept

source $HOME/.config/zsh/plugins/zsh-syntax-highlightning/zsh-syntax-highlighting.zsh
# (( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[path]=none
# ZSH_HIGHLIGHT_STYLES[path_prefix]=none
