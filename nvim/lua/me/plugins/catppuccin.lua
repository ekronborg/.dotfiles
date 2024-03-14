return {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            no_italic = true,
            no_underline = true,
            highlight_overrides = {
                all = function(colors)
                    return {
                        CursorLine = { bg = "none" },
                    }
                end,
            },
        })
        vim.opt.termguicolors = true
        vim.cmd.colorscheme("catppuccin")
    end,
}
