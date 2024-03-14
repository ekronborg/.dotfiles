local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Misc
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "vimwiki/vimwiki",
    "mbbill/undotree",

    -- Syntax highlighting
    "sheerun/vim-polyglot",
    "kergoth/vim-bitbake",

    -- Visuals
    "nvim-tree/nvim-web-devicons", -- used by Lualine and Telescope
    "gruvbox-community/gruvbox",
    { "echasnovski/mini.trailspace", version = false },
    "nvim-lualine/lualine.nvim",

    -- Telescope
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- LSP, linting, formatting and completion
    "stevearc/conform.nvim",
    "mfussenegger/nvim-lint",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
})
