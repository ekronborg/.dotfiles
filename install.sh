#!/bin/bash

set -e

# Get path of script and change working directory
DIR="$(dirname "${BASH_SOURCE[0]}")"
cd $DIR

# Dotfiles located in $HOME
DOTFILES=(
    ".bashrc"
    ".xinitrc"
    ".zshenv"
)

# Directories located in $HOME/.config/
DOTDIRS=(
    "alacritty"
    "bat"
    "bspwm"
    "dunst"
    "nvim"
    "polybar"
    "rofi"
    "sxhkd"
    "tmux"
    "wget"
    "zsh"
)

# Create directories if they do not exist already
[[ ! -d $HOME/.config ]] && mkdir $HOME/.config
[[ ! -d $HOME/.local/share ]] && mkdir -p $HOME/.local/share
[[ ! -d $HOME/.cache/zsh ]] && mkdir -p $HOME/.cache/zsh
[[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
[[ ! -d $HOME/.vim ]] && mkdir -p $HOME/.vim

# Create symbolic links to dotfiles in $HOME
for dotfile in "${DOTFILES[@]}"; do
    ln -sfv `pwd`/$dotfile $HOME/$dotfile
done

# Create symbolic links to directories in $HOME/.config/
for dotdir in "${DOTDIRS[@]}"; do
    [[ -d $HOME/.config/$dotdir ]] && rm -rf $HOME/.config/$dotdir
    ln -sfv `pwd`/$dotdir $HOME/.config/
done

# Create symbolic link from vimrc to $HOME/.vim
ln -sfv `pwd`/vimrc $HOME/.vim/

