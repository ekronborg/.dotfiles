return {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
        linters_by_ft = {
            bitbake = { "oelint-adv" },
            json = { "jsonlint" },
            python = { "flake8" }, -- ruff, mypy, pylint also exist
            rst = { "rstcheck" },
            vim = { "vint" },
            yaml = { "yamllint" },
            bash = { "shellcheck" },
        },
    },
    config = function(_, opts)
        local lint = require("lint")

        lint.linters_by_ft = opts.linters_by_ft

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
