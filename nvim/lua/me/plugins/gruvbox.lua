return {
    "ellisonleao/gruvbox.nvim",
    -- enabled = false,
    priority = 1000,
    config = function()
        require("gruvbox").setup({
            underline = false,
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },
            overrides = {
                -- disable background color of signcolumn signs
                GruvboxRedSign = { bg = "none" },
                GruvboxGreenSign = { bg = "none" },
                GruvboxYellowSign = { bg = "none" },
                GruvboxBlueSign = { bg = "none" },
                GruvboxPurpleSign = { bg = "none" },
                GruvboxAquaSign = { bg = "none" },
                GruvboxOrangeSign = { bg = "none" },
                CursorLine = { bg = "none" },
                CursorLineNr = { fg = "#ebdbb2", bg = "none" },

                -- Disable background color of diffs
                diffAdded = { link = "GruvboxGreen" },
                diffRemoved = { link = "GruvboxRed" },
                diffIndexLine = { link = "GruvboxAqua" },

                -- Do not highlight underscore in LSP popups for hover etc
                -- Note that markdownError is actually cleared in /usr/share/nvim/runtime/syntax/lsp_markdown1.vim,
                -- but /usr/share/nvim/runtime/syntax/markdown.vim seems to re-enable it.
                markdownError = { link = "lsp_markdown1" }, -- probably also works with link = "none"
                luaParenError = { link = "luaParen" }, -- probably also works with link = "none"

                -- TODO: test this more
                -- Removes annoying long strings, line-broken strings in bitbake files.
                bbUnmatched = { link = "none" },
            },
        })
        vim.opt.termguicolors = true
        vim.cmd.colorscheme("gruvbox")
        -- vim.api.nvim_set_hl(0, "NormalFlot", { guibg = none } )
    end,
}

-- -- Vimscript version
-- return {
--     "gruvbox-community/gruvbox",
--     priority = 1000, -- make sure to load this before all the other plugins
--     config = function()
--         -- Neovim does not have 't_xx' options, see ':h t_xx'. Thus, it is only nessescary to set 'termguicolors'
--         vim.g.gruvbox_invert_selection = 0
--         vim.g.gruvbox_sign_column = "none"
--         vim.cmd.colorscheme("gruvbox")
--         vim.cmd.highlight({ "CursorLine", "guibg=none" })
--         vim.cmd.highlight({ "CursorLineNr", "guibg=none" })
--         vim.cmd.highlight({ "CursorLineNr", "guifg=#ebdbb2" })
--         vim.opt.termguicolors = true

--         -- It can also be set via vim.cmd (i.e. set)
--         vim.cmd([[
--             let g:gruvbox_invert_selection = '0'
--             let g:gruvbox_sign_column = 'none'
--             colorscheme gruvbox
--             hi CursorLine guibg=none
--             hi CursorLineNr guibg=none guifg=#ebdbb2
--         ]])
--     end,
-- }
