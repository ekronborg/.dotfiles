# Configuration files

This repository contains a collection of my personal configuration files for various tools I use for development. I keep these files in  Git for portability and to ease the setup of new machines.

## Usage

To deploy on a fresh install:

1. Backup your current configurations files
2. `$ git clone https://github.com/ekronborg/.dotfiles.git`
3. `$ git submodule update --init --recursive`
4. `$ ./install.sh`

This will ***remove*** any existing configuration files and create symbolic links to the files included in this repository.

To update:

1. `$ cd ~/.dotfiles`
2. `$ git fetch`
3. `$ git pull`
