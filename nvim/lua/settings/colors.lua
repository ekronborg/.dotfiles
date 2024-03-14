-- Neovim does not have 't_xx' options, see ':h t_xx'. Thus, it is only nessescary to set 'termguicolors'

vim.g.gruvbox_invert_selection = 0
vim.g.gruvbox_sign_column = "none"
vim.cmd.colorscheme("gruvbox")
vim.cmd.highlight({ "CursorLine", "guibg=none" })
vim.cmd.highlight({ "CursorLineNr", "guibg=none" })
vim.cmd.highlight({ "CursorLineNr", "guifg=#ebdbb2" })
vim.opt.termguicolors = true

-- -- It can also be set via vim.cmd (i.e. set)
-- vim.cmd([[
--     let g:gruvbox_invert_selection = '0'
--     let g:gruvbox_sign_column = 'none'
--     colorscheme gruvbox
--     hi CursorLine guibg=none
--     hi CursorLineNr guibg=none guifg=#ebdbb2
-- ]])

-- https://neovim.io/doc/user/lua.html#vim.highlight
vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")
