return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "echasnovski/mini.icons",
    },
    opts = {
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
            border = "thick",
            sign = false,
            -- left_pad = 1,
            right_pad = 1,
            -- highlight_inline = "",

            -- The 'highlight_inline' attribute for the 'code' block defaults to 'RenderMarkdownCode'.
            -- If setting 'fg = gruvbox_bright_green' for 'RenderMarkdownCode', everything inside a code block gets
            -- highlighted bright_green. If using the default value for 'highlight_inline', inline code in headings
            -- become black boxes. To fix this, define a new highlight group and assign it to 'highlight_inline'.
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
    },
}
