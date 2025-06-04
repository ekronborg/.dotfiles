return {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    -- build = "cargo build --release",
    opts_extend = { "sources.default" },
    opts = {
        keymap = {
            ["<C-Space>"] = { "select_and_accept" },
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                },
            },
            menu = {
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                draw = {
                    treesitter = { "lsp" },
                },
            },
            ghost_text = {
                enabled = true,
                show_without_selection = true,
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                path = {
                    opts = {
                        show_hidden_files_by_default = true,
                    },
                },
            },
        },
        cmdline = { enabled = false },
        signature = { enabled = true },
    },
}
