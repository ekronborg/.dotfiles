return {
    "ellisonleao/gruvbox.nvim",
    -- enabled = false,
    priority = 1000,
    opts = {
        underline = false,
        italic = {
            strings = false,
            emphasis = false,
            comments = false,
            operators = false,
            folds = false,
        },
        overrides = {
            -- Disable background color of signcolumn signs
            SignColumn = { bg = "none" },
            GruvboxRedSign = { bg = "none" },
            GruvboxGreenSign = { bg = "none" },
            GruvboxYellowSign = { bg = "none" },
            GruvboxBlueSign = { bg = "none" },
            GruvboxPurpleSign = { bg = "none" },
            GruvboxAquaSign = { bg = "none" },
            GruvboxOrangeSign = { bg = "none" },
            CursorLineNr = { fg = "#ebdbb2", bg = "none" },
            NormalFloat = { bg = "none" },

            -- Disable background color of diffs
            diffAdded = { link = "GruvboxGreen" },
            diffRemoved = { link = "GruvboxRed" },
            diffIndexLine = { link = "GruvboxAqua" },

            -- Do not highlight underscore in LSP popups for hover etc
            -- Note that markdownError is actually cleared in /usr/share/nvim/runtime/syntax/lsp_markdown1.vim,
            -- but /usr/share/nvim/runtime/syntax/markdown.vim seems to re-enable it.
            markdownError = { link = "lsp_markdown1" }, -- probably also works with link = "none"
            luaParenError = { link = "luaParen" }, -- probably also works with link = "none"
            luaError = { link = "lua3" }, -- probably also works with link = "none"

            -- Fixed for BitBake files
            bbUnmatched = { link = "none" },
            ["@keyword.operator.bitbake"] = { link = "bbShFuncRegion" },

            -- Match tabline to statusline and Tmux line
            TabLineFill = { bg = "#3c3836", bold = true },
            TabLineSel = { fg = "#282828", bg = "#a89984", bold = true },

            -- This makes diff code blocks in Markdown look like they are supposed to, i.e., like they do in a plain
            -- *.diff file. Specifically, unchanged text is not highlighted in aqua.
            ["@markup.raw.block.markdown"] = { link = "GruvboxFg1" },

            -- If using code blocks inside quotes, the following text is for some reason highlighted
            -- using markdownCode, which links to GruvboxAqua by default. Linking markdownCode to
            -- GruvboxFg1 instead fixes this issue and it doesn't seem to introduce any new issues.
            markdownCode = { link = "GruvboxFg1" },

            -- For the render-markdown plugin.
            RenderMarkdownCode = { bg = "#1d2021" },
            RenderMarkdownH1Bg = { fg = "#1d2021", bg = "#83a598", bold = true },
            RenderMarkdownH2Bg = { fg = "#1d2021", bg = "#fabd2f", bold = true },
            RenderMarkdownH3Bg = { fg = "#1d2021", bg = "#8ec07c", bold = true },
            RenderMarkdownH4Bg = { fg = "#1d2021", bg = "#d3869b", bold = true },
            RenderMarkdownH5Bg = { fg = "#1d2021", bg = "#b8bb26", bold = true },
            RenderMarkdownH6Bg = { fg = "#1d2021", bg = "#fb4934", bold = true },
            _InlineCode = { fg = "#b8bb26", bg = "#1d2021" },

            -- Make ghost text stand more out
            BlinkCmpGhostText = { link = "Comment" },
        },
    },
    config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.cmd.colorscheme("gruvbox")
        vim.opt.termguicolors = true
        -- vim.api.nvim_set_hl(0, "NormalFlot", { guibg = none } )
    end,
}
