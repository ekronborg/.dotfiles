return {
    "stevearc/conform.nvim",
    -- Load on either :ConformInfo or pressing F5
    cmd = "ConformInfo",
    keys = {
        {
            "<F5>",
            function()
                require("conform").format()
            end,
            mode = { "n", "v" },
        },
    },
    opts = {
        formatters_by_ft = {
            markdown = { "prettier" },
            vimwiki = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            lua = { "stylua" },
            sh = { "shfmt" },
            python = { "isort", "black" }, -- run isort first and then black
            ["_"] = { "trim_whitespace", "trim_newlines" }, -- fallback if filttype has no formatter
        },

        formatters = {
            shfmt = {
                prepend_args = { "--indent", "4", "--case-indent", "-keep-padding" },
            },
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
            prettier = {
                prepend_args = { "--print-width", "120", "--prose-wrap", "always" },
            },
        },
    },
}
