#!/bin/bash

# Get path of script and change working directory
DIR="$(dirname "${BASH_SOURCE[0]}")"
cd $DIR

# Array of dotfiles located in $HOME
DOTFILES=(
    ".alacritty.yml"
    ".bashrc"
    ".tmux.conf"
    ".vimrc"
    "git-prompt.sh"
)

# Create symbolic links to dotfiles
for dotfile in "${DOTFILES[@]}"; do
    ln -sfv `pwd`/$dotfile $HOME/$dotfile
done

# Create symbolic link to the fish directory
ln -sfv `pwd`/fish $HOME/.config/
