# bindkey -v = viins
# bindkey -a = vicmd
# man zshzle for info about bindkey and commands
# run zsh -f 5.9/functions/zkbd to to help genereate sequences
# inpisration from a mix of https://github.com/softmoth/zsh-vim-mode/blob/main/zsh-vim-mode.plugin.zsh
# and ArchWiki.

# Global aliases can break things. Unset before using any non-builtins.
[[ -o aliases ]] && _vim_mode_shopt_aliases=1
builtin set -o no_aliases

bindkey -v
export KEYTIMEOUT=1

function bindkey_vim () {
    local sequence="$1"
    local command="$2"

    bindkey -v "$sequence" "$command"
    bindkey -a "$sequence" "$command"
}

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
# - Home and End generate different sequences in Alacritty and Gnome terminal
#   PgUp and PgDown procudes nonsense by default, so just bind them to up and down history
#   even though I do not use it. In the Zsh section on ArchWiki, beginning-of-buffer-or-history
#   and end-of-buffer-or-history is also suggested.
# - Backspace is needed for backspace to work in insert mode after accepting a suggestion.
[[ -n "${key[Home]}"          ]] && bindkey_vim "${key[Home]}"          beginning-of-line
[[ -n "${key[End]}"           ]] && bindkey_vim "${key[End]}"           end-of-line
[[ -n "${key[Control-Left]}"  ]] && bindkey_vim "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey_vim "${key[Control-Right]}" forward-word
[[ -n "${key[Delete]}"        ]] && bindkey_vim "${key[Delete]}"        delete-char
[[ -n "${key[Backspace]}"     ]] && bindkey -v  "${key[Backspace]}"     backward-delete-char
[[ -n "${key[Shift-Tab]}"     ]] && bindkey_vim "${key[Shift-Tab]}"     reverse-menu-complete
[[ -n "${key[PageUp]}"        ]] && bindkey_vim "${key[PageUp]}"        up-line-or-history
[[ -n "${key[PageDown]}"      ]] && bindkey_vim "${key[PageDown]}"      down-line-or-history
[[ -n "${key[Up]}"            ]] && bindkey_vim "${key[Up]}"      up-line-or-beginning-search
[[ -n "${key[Down]}"          ]] && bindkey_vim "${key[Down]}"      down-line-or-beginning-search
# [[ -n "${key[PageUp]}"        ]] && bindkey_vim "${key[PageUp]}"        beginning-of-buffer-or-history
# [[ -n "${key[PageDown]}"      ]] && bindkey_vim "${key[PageDown]}"      end-of-buffer-or-history

bindkey_vim "^@" autosuggest-accept # zsh-autosuggestions plugin
# bindkey "^R" history-incremental-pattern-search-backward # enable this if not fzf is used

# Compatibility with zsh-autosuggestions; see https://github.com/softmoth/zsh-vim-mode/issues/25
# And yes, zle -N must be two seperate lines.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -a "j" down-line-or-beginning-search
bindkey -a "k" up-line-or-beginning-search
bindkey_vim "^N" down-line-or-beginning-search
bindkey_vim "^P" up-line-or-beginning-search

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Restore shell option 'aliases'. This must be the last thing here.
if [[ $_vim_mode_shopt_aliases = 1 ]]; then
   unset _vim_mode_shopt_aliases
   set -o aliases
fi
