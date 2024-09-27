return {
    -- Requires undodir to be set. Defaults to $XDG_STATE_HOME/nvim/undo/ and is automatically created
    -- Note that undofile must be true for persistence
    "mbbill/undotree",
    -- vim.g.foo needs to be set in init(). See  https://github.com/LazyVim/LazyVim/discussions/258
    init = function()
        -- https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim#L27
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_SplitWidth = 45 -- Enough to show help menu
    end,

    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", mode = { "n", "v" } },
    },
}
