# Configuration files

This repository is a collection of my personal configuration files used for version control and to setup fresh installations. Currently, configurations files are included for:

* Alacritty
* Bash
* bat
* bspwm
* Dunst
* Fish
* Git
* i3
* i3status
* Neovim
* Polybar
* sxhkd
* Tmux
* Vim
* Wget
* Zsh

## Usage

To deploy on a fresh install:

1. Backup your current configurations files
2. Clone this repository
3. `$ git submodule init`
4. `$ ./install.sh`

Please note that this will ***remove*** any existing configuration files and afterwards create symbolic links to the files included in this repository.

To update:

1. `$ cd ~/.dotfiles`
2. `$ git fetch`
3. `$ git pull`
3. `$ git submodule update --remote`

## Tips

* To use systemwide copy/paste with Vim, it must be compiled with `xterm_clipboard`. You can check this with `vim --version | grep xterm_clipboard`. If it is not installed, the gui-version of Vim is typically compiled with `xterm_clipboard` and can be installed alongside the regular version of Vim.
* If you use Gnome DE (or PopOS!), you can install `gnome-tweaks` and switch Esc and Caps Lock. In other distros with `X11`, this can be done with `$ setxkbmap -option caps:escape`.

