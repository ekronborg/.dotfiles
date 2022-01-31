#!/bin/bash

set -e

# Get path of script and change working directory
DIR="$(dirname "${BASH_SOURCE[0]}")"
cd $DIR

# Dotfiles located in $HOME
DOTFILES=(
    ".bashrc"
    ".vimrc"
)

# Directories located in $HOME/.config/ (and git-prompt.sh)
DOTDIRS=(
    "alacritty"
    "fish"
    "nvim"
    "tmux"
    "git-prompt.sh"
)

# Create symbolic links to dotfiles in $HOME
for dotfile in "${DOTFILES[@]}"; do
    ln -sfv `pwd`/$dotfile $HOME/$dotfile
done

# Create symbolic links to directories in $HOME/.config/
for dotdir in "${DOTDIRS[@]}"; do
    ln -sfv `pwd`/$dotdir $HOME/.config/
done
