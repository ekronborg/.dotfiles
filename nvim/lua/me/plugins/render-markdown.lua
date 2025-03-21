return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "echasnovski/mini.icons",
    },
    config = function()
        local gruvbox = require("gruvbox").palette
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = gruvbox.dark0_hard })
        -- The 'highlight_inline' attribute for the 'code' block defaults to 'RenderMarkdownCode'.
        -- If setting 'fg = gruvbox_bright_green' for 'RenderMarkdownCode', everything inside a code block gets
        -- highlighted bright_green. If using the default value for 'highlight_inline', inline code in headings
        -- become black boxes. To fix this, define a new highlight group and assign it to 'highlight_inline'.
        vim.api.nvim_set_hl(0, "_InlineCode", { fg = gruvbox.bright_green, bg = gruvbox.dark0_hard })
        -- stylua: ignore start
        vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = gruvbox.dark0_hard, bg = gruvbox.bright_blue, bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = gruvbox.dark0_hard, bg = gruvbox.bright_yellow, bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = gruvbox.dark0_hard, bg = gruvbox.bright_aqua, bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = gruvbox.dark0_hard, bg = gruvbox.bright_purple, bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = gruvbox.dark0_hard, bg = gruvbox.bright_green, bold = true })
        vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = gruvbox.dark0_hard, bg = gruvbox.bright_red, bold = true })
        -- stylua: ignore end

        require("render-markdown").setup({
            render_modes = { "n", "v", "V", "\22", "c", "t" },

            anti_conceal = {
                enabled = true,
                -- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki#anti-conceal
                ignore = {
                    head_icon = true,
                    head_background = true,
                    code_language = false,
                    code_background = true,
                    dash = true,
                    bullet = true,
                    quote = true,
                    link = true,
                    sign = true,
                },
            },

            heading = {
                sign = false,
                -- icons = {},
                -- position = "inline",
                -- border = true,
            },

            code = {
                disable_background = {},
                width = "block",
                sign = false,
                -- left_pad = 1,
                right_pad = 1,
                -- highlight_inline = "",
                highlight_inline = "_InlineCode",
            },

            pipe_table = {
                head = "RenderMarkdownTableRow",
            },

            -- Disable plugin for floating windows and popups
            -- https://github.com/MeanderingProgrammer/render-markdown.nvim/commit/873bdee806e381864a55f692bcbfe23269c8dc9d
            -- https://github.com/MeanderingProgrammer/render-markdown.nvim/discussions/285
            -- overrides = {
            --     buflisted = { [false] = { enabled = false } },
            -- },
        })
    end,
}
