return {
    "rebelot/kanagawa.nvim",
    enabled = false,
    priority = 1000,
    config = function()
        require("kanagawa").setup({
            commentStyle = { italic = false },
            keywordStyle = { italic = false },
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                            bg_p2 = "none",
                            bg_p1 = "none",
                        },
                    },
                },
            },
        })
        vim.opt.termguicolors = true
        vim.cmd.colorscheme("kanagawa")
    end,
}
