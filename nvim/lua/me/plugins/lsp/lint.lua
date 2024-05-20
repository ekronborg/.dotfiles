return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            bitbake = { "oelint-adv" },
            json = { "jsonlint" },
            python = { "flake8" }, -- ruff, mypy, pylint also exist
            rst = { "rstcheck" },
            vim = { "vint" },
            yaml = { "yamllint" },
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
