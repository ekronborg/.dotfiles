return {
    "sheerun/vim-polyglot",
    enabled = false,
    -- https://github.com/LazyVim/LazyVim/discussions/258
    init = function()
        -- do not change default settings other than syntax highlighting
        vim.g.polyglot_disabled = { "autoindent", "sensible", "ftdetect" }
    end,
}
