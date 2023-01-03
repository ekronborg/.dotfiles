#!/bin/bash

set -e

# Get path of script and change working directory
DIR="$(dirname "${BASH_SOURCE[0]}")"
cd "$DIR"

echo "------------------------------------------------------------------------------------"
echo "Enabling the RPM Fusion repositories..."
echo "------------------------------------------------------------------------------------"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "------------------------------------------------------------------------------------"
echo "Updating the system..."
echo "------------------------------------------------------------------------------------"
sudo dnf -y upgrade

echo "------------------------------------------------------------------------------------"
echo "Installing packages..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy install alacritty curl dnf-plugins-core fd-find flatpak fzf gnome-tweaks htop \
    neofetch neovim ripgrep tmux gvim wget zsh python3-pip shellcheck bmap-tools meld tio \
    sphinx python3-sphinx_rtd_theme exa bat docker moby-engine sshd automake autoconf dtc \
    uboot-tools cmake ninja-build

echo "------------------------------------------------------------------------------------"
echo "Enabling the Flathub repository..."
echo "------------------------------------------------------------------------------------"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Yocto dependencies (https://docs.yoctoproject.org/ref-manual/system-requirements.html#fedora-packages)
echo "------------------------------------------------------------------------------------"
echo "Installing Yocto dependencies for Langdale..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy install gawk make wget tar bzip2 gzip python3 unzip perl patch \
    diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath ccache perl-Data-Dumper \
    perl-Text-ParseWords perl-Thread-Queue perl-bignum socat python3-pexpect findutils which file \
    cpio python python3-pip xz python3-GitPython python3-jinja2 SDL-devel xterm rpcgen mesa-libGL-devel \
    perl-FindBin perl-File-Compare perl-File-Copy perl-locale zstd lz4

echo "------------------------------------------------------------------------------------"
echo "Installing development tools..."
echo "------------------------------------------------------------------------------------"
sudo dnf -qy groupinstall "Development Tools"

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
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/UbuntuMono.zip
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
systemctl enable --now docker
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
echo "Remember to disable SELinux!"
echo "----------------------------------------------------------------------------------------"
