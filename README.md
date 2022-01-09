# Configuration files

This repository is a collection of my personal configuration files used for version control and to setup fresh installations. Currently, configurations files are included for:

* Alacritty
* Bash
* Tmux
* Vim
* Fish

## Usage

To deploy on a fresh install, do the following:

1. Backup your current configurations files
2. Clone this repository
3. Run `install.sh` 

Please note that `install.sh` will ***remove*** any existing configuration files and afterwards create symbolic links to the files included in this repository. Herefter, the the latest changes can be pulled from git by `git pull`.

## Dependencies

* [exa](https://the.exa.website/introduction)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [vim-plug](https://github.com/junegunn/vim-plug)

## Tips

* To use systemwide copy/paste with Vim, it must be compiled with `xterm_clipboard`. You can check this with `vim --version | grep xterm_clipboard`. If it is not installed, the gui-version of Vim is typically compiled with `xterm_clipboard` and can be installed alongside the regular version Vim.

## TODO

* Include automatic backup of old configurations files (append with `.bak`)

