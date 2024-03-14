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
    spec = {
        { import = "me.plugins" },
        { import = "me.plugins.lsp" },
    },
    change_detection = { notify = false },
    performance = {
        rtp = {
            disabled_plugins = {
                -- ls -l /usr/share/nvim/runtime/plugin to get a list. Loaded plugins can also be seen in the Lazy UI.
                -- NOTE: this is under 1 ms in total
                "editorconfig",
                "gzip",
                "netrwPlugin",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
