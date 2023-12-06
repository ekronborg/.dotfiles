#!/bin/bash

set -e

# Get path of script and change working directory
DIR="$(dirname "${BASH_SOURCE[0]}")"
cd "$DIR"

echo "------------------------------------------------------------------------------------"
echo "Enabling the RPM Fusion repositories..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -qy install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -qy group update core

echo "------------------------------------------------------------------------------------"
echo "Updating the system..."
echo "------------------------------------------------------------------------------------"
sudo dnf -y upgrade

echo "------------------------------------------------------------------------------------"
echo "Installing packages..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy install alacritty curl dnf-plugins-core fd-find flatpak fzf gnome-tweaks htop \
    neofetch neovim ripgrep tmux gvim wget zsh python3-pip shellcheck bmap-tools tig tio \
    exa bat moby-engine sshd dtc uboot-tools cmake ninja-build vlc cross-binutils-common \
    cross-gcc-common kernel-cross-headers binutils-aarch64-linux-gnu gcc-aarch64-linux-gnu \
    gcc-c++-aarch64-linux-gnu binutils-arm-linux-gnu gcc-arm-linux-gnu gcc-c++-arm-linux-gnu \
    arm-none-eabi-binutils-cs arm-none-eabi-gcc-cs arm-none-eabi-gcc-cs-c++ arm-none-eabi-newlib

sudo dnf -qy groupinstall "C Development Tools and Libraries" "Development Tools"

echo "------------------------------------------------------------------------------------"
echo "Installing multimedia codecs..."
echo "------------------------------------------------------------------------------------"
# From https://rpmfusion.org/Howto/Multimedia
sudo dnf -qy install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 \
    gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf -qy install lame\* --exclude=lame-devel
sudo dnf -qy group upgrade --with-optional Multimedia

# From https://docs.fedoraproject.org/en-US/quick-docs/openh264/
sudo dnf -qy config-manager --set-enabled fedora-cisco-openh264
sudo dnf -qy install gstreamer1-plugin-openh264 mozilla-openh264

# From https://docs.fedoraproject.org/en-US/quick-docs/installing-plugins-for-playing-movies-and-music/
# Note that 'intel-media-driver' assumes that the computer has an intel CPU and no discrete GPU.
sudo dnf -qy swap ffmpeg-free ffmpeg --allowerasing
sudo dnf -qy groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf -qy groupupdate sound-and-video
sudo dnf -qy install intel-media-driver


echo "------------------------------------------------------------------------------------"
echo "Enabling the Flathub repository..."
echo "------------------------------------------------------------------------------------"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    echo "------------------------------------------------------------------------------------"
    echo "Installing vim-plug for Vim..."
    echo "------------------------------------------------------------------------------------"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall ; vimx +PlugInstall +qall
fi

if [[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]; then
    echo "------------------------------------------------------------------------------------"
    echo "Installing vim-plug for Neovim..."
    echo "------------------------------------------------------------------------------------"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    nvim +PlugInstall +qall
fi

echo "----------------------------------------------------------------------------------------"
echo "Installing Ubuntu Mono Nerd font..."
echo "----------------------------------------------------------------------------------------"
pushd "$HOME"/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.zip
unzip -d ubuntu-mono-nerd UbuntuMono.zip
cd ubuntu-mono-nerd
find . -iname "*windows*" -exec rm {} \;
sudo mkdir -p /usr/local/share/fonts/ttf/ubuntu-mono-nerd
sudo cp -r . /usr/local/share/fonts/ttf/ubuntu-mono-nerd/
sudo fc-cache -v
popd

echo "----------------------------------------------------------------------------------------"
echo "Enabling systemd services..."
echo "----------------------------------------------------------------------------------------"
systemctl enable --now sshd
systemctl disable --now firewalld

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

echo "----------------------------------------------------------------------------------------"
echo "* Disable SELinux"
echo "* Disable firewall"
echo "* Disable kernel audit framework. See ArchWiki and Fedora docs"
echo "* Enable docker.service if the development environment has not yet moved to Podman"
echo "* Firefox -> Add-ons -> Plugins -> Enable OpenH264"
echo "* Check also https://docs.fedoraproject.org/en-US/quick-docs/openh264/#_firefox_config_changes for OpenH264 in Firefox"
echo "* Check https://rpmfusion.org/Howto/Multimedia for hardware acceleration and to see if anything was missed regarding codecs etc"
echo "----------------------------------------------------------------------------------------"
