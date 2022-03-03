#!/bin/bash

set -e

# Update and upgrade
echo "Updating the system"
sudo apt-get -qq update && sudo apt-get -qqy upgrade

# Packages to install
PACKAGES=(
    "alacritty"
    "bat"
    "build-essential"
    "cmake"
    "curl"
    "exa"
    "fish"
    "fonts-font-awesome"
    "fonts-hack"
    "fonts-jetbrains-mono"
    "fzf"
    "htop"
    "neofetch"
    "ninja-build"
    "podman"
    "ranger"
    "ripgrep"
    "tmux"
    "vim"
    "vim-gtk3"
    "wget"
    "zsh"
)

# Install the above packages
echo "------------------------------------------------------------------------------------"
echo "Installing packages..."
echo "------------------------------------------------------------------------------------"
for package in "${PACKAGES[@]}"; do
    echo "Installing ${package}"
    sudo apt-get -qqy install $package
done

# Install vim-plug for Vim if not installed
if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    echo "------------------------------------------------------------------------------------"
    echo "Installing Vim-plug for Vim..."
    echo "------------------------------------------------------------------------------------"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install vim-plug for Neovim if not installed
if [[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]; then
    echo "------------------------------------------------------------------------------------"
    echo "Installing Vim-plug for Neovim..."
    echo "------------------------------------------------------------------------------------"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Bat(cat) settings. Debian use a weird name
echo "------------------------------------------------------------------------------------"
echo "Bat(cat) settings..."
echo "------------------------------------------------------------------------------------"
mkdir -pv $HOME/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

read -r -p "Source dotfiles and set up symlinks? [Y/n] " input
case $input in
      [yY][eE][sS]|[yY])
            source $PWD/install.sh
            ;;
      [nN][oO]|[nN])
            exit 0
            ;;
      *)
            echo "Invalid input..."
            exit 1
            ;;
esac

