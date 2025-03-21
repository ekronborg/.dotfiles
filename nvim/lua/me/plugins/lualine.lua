return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "gruvbox",
                -- component_separators = "",
                -- section_separators = { left = "", right = "" },
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
                disabled_filetypes = {
                    "man",
                },
            },
            sections = {
                lualine_b = {
                    "branch",
                    {
                        "diff",
                        symbols = { added = " ", modified = " ", removed = " " },
                    },
                    "lsp_status",
                    {
                        "diagnostics",
                        symbols = { error = " ", warn = " ", hint = " ", info = " " },
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        symbols = { readonly = "󰌾" },
                    },
                },
            },
        })
    end,
}
