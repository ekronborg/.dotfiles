return {
    "lukas-reineke/headlines.nvim",
    ft = "markdown",
    config = function()
        local gruvbox = require("gruvbox").palette
        require("headlines").setup({
            vim.api.nvim_set_hl(0, "CodeBlock", { bg = gruvbox.dark0_hard }),
            vim.api.nvim_set_hl(0, "Dash", { fg = gruvbox.bright_yellow }),
            vim.api.nvim_set_hl(0, "Headline1", { bg = gruvbox.bright_blue, fg = gruvbox.dark0 }),
            vim.api.nvim_set_hl(0, "Headline2", { bg = gruvbox.bright_yellow, fg = gruvbox.dark0 }),
            vim.api.nvim_set_hl(0, "Headline3", { bg = gruvbox.bright_aqua, fg = gruvbox.dark0 }),
            vim.api.nvim_set_hl(0, "Headline4", { bg = gruvbox.bright_purple, fg = gruvbox.dark0 }),
            vim.api.nvim_set_hl(0, "Headline5", { bg = gruvbox.bright_green, fg = gruvbox.dark0 }),
            vim.api.nvim_set_hl(0, "Headline6", { bg = gruvbox.bright_red, fg = gruvbox.dark0 }),
            markdown = {
                -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
                bullets = {},
                headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
                fat_headlines = false,
            },
        })
        vim.opt.conceallevel = 2
    end,
}
