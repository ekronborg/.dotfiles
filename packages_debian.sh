#!/bin/bash

set -e

# # Update and upgrade
sudo apt-get update && sudo apt-get upgrade -y

# Packages to install
PACKAGES=(
    "alacritty"
    "tmux"
    "vim"
    "vim-gtk3"
    "fish"
    "ripgrep"
    "cargo"
    "ranger"
    "git"
    "curl"
    "wget"
    "build-essential"
    "cmake"
    "ninja-build"
    "docker.io"
    "fzf"
    "neofetch"
    "htop"
)

# Install the above packages
for package in "${PACKAGES[@]}"; do
    sudo apt-get install -y $package
done

# Install exa and add to path
cargo install exa
if [[ ! "$PATH" =~ (^|:)"$HOME/.cargo/bin"(|/)(:|$) ]]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

# Install vim-plug if not installed
if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
