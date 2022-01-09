## Configuration files

This repository is a collection of my personal configuration files used for:

1. Deploying my configurations on fresh installations
2. Version control.

Currently, configurations files are included for:

* Alacritty
* Bash
* Tmux
* Vim
* Fish

### Usage

##### Deploying

1. Backup your current configurations files
2. Clone this repository
3. Run `install.sh` 

Please note that this will remove any existing configuration files and afterwards create symbolic links.

##### Updating

1. `git pull`

### Dependencies

* [exa](https://the.exa.website/introduction)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [vim-plug](https://github.com/junegunn/vim-plug)

### Tips

* To use systemwide copy/paste with Vim, it must be compiled with `xterm_clipboard`. You can check this with `vim --version | grep xterm_clipboard`. If it is not installed, the gui-version of Vim typically includes `xterm_clipboard` and can be installed alongside regular Vim.

### TODO

* Include automatic backup of old configurations files (append with `.bak`)

