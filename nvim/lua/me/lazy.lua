-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


-- From LazyVim repo: lua/lazyvim/util/plugin.lua
local M = {}
M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }
function M.lazy_file()
    -- Add support for the LazyFile event
    local Event = require("lazy.core.handler.event")

    Event.mappings.LazyFile = { id = "LazyFile", event = M.lazy_file_events }
    Event.mappings["User LazyFile"] = Event.mappings.LazyFile
end

require("lazy").setup({
    M.lazy_file(),
    spec = {
        { import = "me.plugins" },
        { import = "me.plugins.lsp" },
    },
    ui = {
        border = "rounded",
        backdrop = 100,
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
