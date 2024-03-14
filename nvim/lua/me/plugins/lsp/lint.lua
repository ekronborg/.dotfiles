return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
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

        local flake8 = require("lint").linters.flake8
        flake8.args = {
            "--line-length 120",
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })

        -- vim.keymap.set("n", "<leader>l", function()
        --     require("lint").try_lint()
        -- end, { desc = "Trigger linting for current file" })
    end,
}
