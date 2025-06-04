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
                    { "branch", separator = "" },
                    { "diff", symbols = { added = " ", modified = " ", removed = " " } },
                },
                lualine_c = {
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", path = 1, symbols = { readonly = "󰌾" }, padding = { left = 0, right = 0 } },
                },
                lualine_x = {},
                lualine_y = {
                    { "lsp_status", separator = "" },
                    { "diagnostics", symbols = { error = " ", warn = " ", hint = " ", info = " " } },
                },
                lualine_z = {
                    { "progress", separator = " ", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
            },
        }
        return opts
    end,
}
