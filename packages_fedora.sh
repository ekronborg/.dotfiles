#!/bin/bash

set -e

# Get path of script and change working directory
DIR="$(dirname "${BASH_SOURCE[0]}")"
cd $DIR

# Update the system
echo "------------------------------------------------------------------------------------"
echo "Updating the system..."
echo "------------------------------------------------------------------------------------"
sudo dnf -y upgrade

# Packages to install
PACKAGES=(
    "alacritty"
    "tmux"
    "neovim"
    "fish"
    "ripgrep"
    "cargo"
    "ranger"
    "curl"
    "wget"
    "podman"
    "dnf-plugins-core"
    "fzf"
    "neofetch"
    "htop"
)

# Install the above packages
echo "------------------------------------------------------------------------------------"
echo "Installing packages..."
echo "------------------------------------------------------------------------------------"
for package in "${PACKAGES[@]}"; do
    echo "Installing ${package}"
    sudo dnf -qy install $package
done

# Yocto dependencies (https://www.yoctoproject.org/docs/1.8/yocto-project-qs/yocto-project-qs.html)
echo "------------------------------------------------------------------------------------"
echo "Installing Yocto dependencies..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy install gawk make wget tar bzip2 gzip python unzip perl patch \
diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath \
ccache perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue socat \
findutils which SDL-devel xterm

# Install Docker (https://developer.fedoraproject.org/tools/docker/docker-installation.html)
echo "------------------------------------------------------------------------------------"
echo "Installing Docker..."
echo "------------------------------------------------------------------------------------"
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -qy install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo docker run hello-world

echo "------------------------------------------------------------------------------------"
echo "Installing development tools..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy groupinstall "Development Tools"

# Install exa and add to path
echo "------------------------------------------------------------------------------------"
echo "Installing exa..."
echo "------------------------------------------------------------------------------------"
cargo install exa
if [[ ! "$PATH" =~ (^|:)"$HOME/.cargo/bin"(|/)(:|$) ]]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

# Install vim-plug for Vim if not installed
if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    echo "------------------------------------------------------------------------------------"
    echo "Installing Vim-plug for Vim"
    echo "------------------------------------------------------------------------------------"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install vim-plug for Neovim if not installed
if [[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]; then
    echo "------------------------------------------------------------------------------------"
    echo "Installing Vim-plug for Neovim"
    echo "------------------------------------------------------------------------------------"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Reminder to install hack font
echo "----------------------------------------------------------------------------------------"
echo "Remember to install Hack font!"
echo "----------------------------------------------------------------------------------------"

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

