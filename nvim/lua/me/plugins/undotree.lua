return {
    -- Requires undodir to be set. Defaults to $XDG_STATE_HOME/nvim/undo/ and is automatically created
    -- Note that undofile must be true for persistence
    "mbbill/undotree",
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", mode = { "n", "v" } },
    },
}
