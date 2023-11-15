# Add to path
export PATH=$HOME/.local/bin:$PATH

# System settings
export COLORTERM="truecolor"
# Prior to fd v0.8.3 `--strip-cwd-prefix` does not exist and should therefore not be included!
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
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

# Clean up $HOME. Relevant links:
# - https://github.com/b3nj5m1n/xdg-ninja
# - https://wiki.archlinux.org/title/XDG_Base_Directory#Support
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/pythonrc"
export PARALLEL_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/parallel"
export ANSIBLE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/ansible"
export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/nv"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
export XAUTHORITY="${XDG_RUNTIME_DIR:-/run/user/$UID}/Xauthority"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
export LESSHISTFILE="-"

# Fix for using Java applications with WMs
export _JAVA_AWT_WM_NONREPARENTING=1

# Nvidia hardware acceleration
# See https://github.com/elFarto/nvidia-vaapi-driver/ for details
export MOZ_DISABLE_RDD_SANDBOX=1
export LIBVA_DRIVER_NAME=nvidia
export NVD_BACKEND=direct
