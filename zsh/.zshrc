# # Source global definitions (if any)
# if [[ -f /etc/zshrc ]]; then
#     . /etc/zshrc
# fi

# Set options (https://zsh.sourceforge.io/Doc/Release/Options.html)
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
setopt extended_glob
setopt prompt_subst

# Set up search history
HISTFILE=~/.cache/zsh/history
HISTSIZE=50000
SAVEHIST=10000

# Enable Vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^R' history-incremental-pattern-search-backward

# Colors
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
autoload -U colors && colors

# Completion menu
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
_comp_options+=(globdots)

# Generate prompt (https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Visual-effects)
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# PROMPT='[%n@%m %F{#689d6a}%~%f%F{#458588}$(parse_git_branch)%f]%# '
PROMPT='%F{#689d6a}%~%f%F{#458588}$(parse_git_branch)%f %F{#b16286}❯%f '
# PROMPT='%F{#689d6a}%~%f%F{#458588}$(parse_git_branch)%f %F{#d79921}%f '

# Aliases
source $HOME/.config/zsh/aliases

# Source plugins (remember to update the repositories once in a while)
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept
# source $HOME/.config/zsh/plugins/zsh-syntax-highlightning/zsh-syntax-highlighting.zsh
