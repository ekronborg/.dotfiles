#!/bin/bash

set -e

# Get path of script and change working directory
DIR="$(dirname "${BASH_SOURCE[0]}")"
cd "$DIR"

# Enable the RPM Fusion repositories
echo "------------------------------------------------------------------------------------"
echo "Enabling the RPM Fusion repositories..."
echo "------------------------------------------------------------------------------------"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm

# Enable the flathub repository
echo "------------------------------------------------------------------------------------"
echo "Enabling the Flathub repository..."
echo "------------------------------------------------------------------------------------"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Update the system
echo "------------------------------------------------------------------------------------"
echo "Updating the system..."
echo "------------------------------------------------------------------------------------"
sudo dnf -y upgrade

# Packages to install
PACKAGES=(
    "alacritty"
    "curl"
    "dnf-plugins-core"
    "fd-find"
    "fish"
    "flatpak"
    "fzf"
    "gnome-tweaks"
    "htop"
    "jetbrains-mono-fonts-all"
    "neofetch"
    "neovim"
    "podman"
    "ranger"
    "ripgrep"
    "tmux"
    "vim-enhanced"
    "wget"
    "zsh"
)

# Install the above packages
echo "------------------------------------------------------------------------------------"
echo "Installing packages..."
echo "------------------------------------------------------------------------------------"
for package in "${PACKAGES[@]}"; do
    echo "Installing ${package}"
    sudo dnf -qy install "$package"
done

# Yocto dependencies (https://docs.yoctoproject.org/ref-manual/system-requirements.html#fedora-packages)
echo "------------------------------------------------------------------------------------"
echo "Installing Yocto dependencies..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy install gawk make wget tar bzip2 gzip python3 unzip perl patch \
diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath \
ccache perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue perl-bignum socat \
python3-pexpect findutils which file cpio python python3-pip xz python3-GitPython \
python3-jinja2 SDL-devel xterm rpcgen mesa-libGL-devel perl-FindBin \
perl-File-Compare perl-File-Copy perl-locale zstd lz4

echo "------------------------------------------------------------------------------------"
echo "Installing development tools..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy groupinstall "Development Tools"

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

# Reminder to install hack font
echo "----------------------------------------------------------------------------------------"
echo "Remember to install Hack font!"
echo "----------------------------------------------------------------------------------------"

read -r -p "Source dotfiles and set up symlinks? [Y/n] " input
case $input in
      [yY][eE][sS]|[yY])
            "$PWD"/install.sh
            ;;
      [nN][oO]|[nN])
            exit 0
            ;;
      *)
            echo "Invalid input..."
            exit 1
            ;;
esac

