-- Globals
vim.g.mapleader = " " -- necessary for some plugins
vim.g.c_syntax_for_h = 1 -- see :h c.vim
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

require("me.config")
require("me.lazy")
