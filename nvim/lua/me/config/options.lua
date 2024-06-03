vim.opt.path:append("**")
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.scrolloff = 5
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.guicursor = ""
vim.opt.updatetime = 300
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.number = true
vim.opt.signcolumn = "number"
vim.opt.cursorline = true
vim.opt.grepprg = "rg --vimgrep"
-- vim.opt.tags = "./tags;" -- Neovim sets "./tags;,tags" by default