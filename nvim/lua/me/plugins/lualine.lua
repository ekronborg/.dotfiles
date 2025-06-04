return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "echasnovski/mini.icons",
            -- https://github.com/nvim-lualine/lualine.nvim/issues/1378
            init = function()
                require("mini.icons").mock_nvim_web_devicons()
            end,
        },
    },
    opts = function()
        -- See LazyVim commit 13dbe4ad55a4 ("perf(lualine): get rid of lualine's weird lualine_require")
        local lualine_require = require("lualine_require")
        lualine_require.require = require

        local opts = {
            options = {
                -- component_separators = "",
                -- section_separators = { left = "", right = "" },
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
                disabled_filetypes = { "man" },
                ignore_focus = { "snacks_picker_input", "snacks_picker_list", "fugitiveblame", "mason", "lazy" },
            },
            sections = {
                lualine_b = {
                    "branch",
                    { "diff", symbols = { added = " ", modified = " ", removed = " " } },
                    "lsp_status",
                    { "diagnostics", symbols = { error = " ", warn = " ", hint = " ", info = " " } },
                },
                lualine_c = {
                    { "filename", symbols = { readonly = "󰌾" } },
                },
                lualine_x = {},
            },
        }
        return opts
    end,
}
