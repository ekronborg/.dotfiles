#!/bin/bash

set -e

# Update and upgrade
echo "Updating the system"
sudo apt-get -qq update && sudo apt-get -qqy upgrade

# Packages to install
PACKAGES=(
    "alacritty"
    "tmux"
    "vim"
    "vim-gtk3"
    "fonts-hack"
    "fish"
    "ripgrep"
    "cargo"
    "ranger"
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
    echo "Installing ${package}"
    sudo apt-get -qqy install $package
done

# Install exa and add to path
cargo install exa
if [[ ! "$PATH" =~ (^|:)"$HOME/.cargo/bin"(|/)(:|$) ]]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

# Install vim-plug for Vim if not installed
if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install vim-plug for Neovim if not installed
if [[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
