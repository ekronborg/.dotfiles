return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            mode = "tabs",
            numbers = "ordinal",
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(_, _, diag)
                local ret = (diag.error and " " .. diag.error .. " " or "")
                    .. (diag.warning and " " .. diag.warning or "")
                return vim.trim(ret)
            end,
            offsets = { { filetype = "snacks_layout_box" } },
            always_show_bufferline = false,
            show_duplicate_prefix = false,
        },
        -- Note that these colors are not "pure" Gruvbox colors. The bufferline plugin
        -- uses a function, shade_color(), to darken some colors.
        highlights = {
            buffer_selected = { italic = false },
            numbers_selected = { italic = false },
            info_selected = { italic = false },
            info_diagnostic_selected = { italic = false },
            -- warning_diagnostic = { fg = "#bb8d23" },
            warning_selected = { italic = false },
            warning_diagnostic_selected = { bold = false, italic = false },
            -- error_diagnostic = { fg = "#bc3627" },
            error_selected = { italic = false },
            error_diagnostic_selected = { bold = false, italic = false },
            indicator_selected = { fg = "#a89984" },
        },
    },
}
