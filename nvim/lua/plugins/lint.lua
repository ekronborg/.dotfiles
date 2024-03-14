require("lint").linters_by_ft = {
    python = { "flake8" }, -- ruff, mypy, pylint also exist
    yaml = { "yamllint" },
    json = { "jsonlint" },
    vim = { "vint" },
    -- sh = {"shellcheck"}, -- part of bashls LSP
    -- lua = {"luacheck"}, -- shows same information as lua_ls
    -- markdown = {"markdownlint"}, -- useless for my use case
    -- vimwiki = {"markdownlint"},
    -- markdown = {"vale"}, -- vale requires global a configuration to be available
    -- vimwiki = {"vale"},
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

-- vim.keymap.set("n", "<leader>l", function()
--     require("lint").try_lint()
-- end, { desc = "Trigger linting for current file" })
