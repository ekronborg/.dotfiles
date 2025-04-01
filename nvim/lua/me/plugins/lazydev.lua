return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        cmd = "LazyDev",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "lazydev" }, -- add lazydev to your completion providers
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- make lazydev completions top priority (see `:h blink.cmp`)
                    },
                },
            },
        },
    },
}
