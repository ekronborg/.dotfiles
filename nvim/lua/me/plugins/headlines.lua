return {
    "lukas-reineke/headlines.nvim",
    ft = "markdown",
    config = function()
        local gruvbox = require("gruvbox").palette
        require("headlines").setup({
            vim.api.nvim_set_hl(0, "CodeBlock", { bg = gruvbox.dark0_hard }),
            vim.api.nvim_set_hl(0, "Dash", { fg = gruvbox.bright_yellow }),
            markdown = {
                -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
                bullets = {},
            },
        })
        vim.opt.conceallevel = 2
    end,
}
