### Location of files
- `~/.vimrc`
- `~/.bashrc` 
- `~/.tmux.conf`
- `~/.config/fish`
- `~/.alacritty.yml`
- `~/.mozilla/firefox/<profile name>/user-overrides.js`

### Misc
- To copy/paste between Vim and other programs, Vim with `xterm_clipboard` must be installed. To check if this is installed, see the output of `vim --version | grep xterm`. If not installed, it can easily be installed by installing Gvim: `sudo apt install vim-gtk3`.
- Ripgrep must be installed to use `:Rg` with the pluging for fzf: `sudo apt install ripgrep`.
- See https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim for black hole register, i.e., delete something without saving it in a register that is being used.

