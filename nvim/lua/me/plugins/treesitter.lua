return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "VeryLazy", "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    opts = {
        -- See https://github.com/nvim-treesitter/nvim-treesitter/issues/236 for "comment"
        ensure_installed = {
            "bash",
            "bitbake",
            "c",
            "comment",
            "cpp",
            "devicetree",
            "diff",
            "go",
            "json",
            "jsonc",
            "kconfig",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "perl",
            "python",
            "query",
            "rasi",
            "regex",
            "rst",
            "rust",
            "sql",
            "toml",
            "vim",
            "vimdoc",
            "yaml",
            -- "cmake",
            -- "disassembly",
            -- "dockerfile",
            -- "meson",
            -- "objdump",
        },

        -- Automatically install missing parsers when entering buffer. Requires tree-sitter CLI to be installed.
        -- For example, when opening tmux.conf, the tmux module is installed because ft=tmux and tmux is not
        -- part of ensure_installed.
        auto_install = false,

        -- This basically does ':set syntax=markdown'. Using treesitter, some highlighting is missing, for example,
        -- strike through, bold, and italic.  Without treesitter or polyglot, strike trough links to 'htmlStrike',
        -- so I think it can also be set directly via vim.api.nvim_set_hl.
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = {
                "markdown",
                "bitbake",
            },
        },

        indent = {
            enable = true,
            disable = {
                "yaml.gitlab",
            },
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
                include_surrounding_whitespace = true,
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                },
            },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
        -- See https://github.com/NvChad/NvChad/issues/1907 and ':h vim.highlight.priorities'.
        -- Treesitter highlighting has priority 100, so this effectively disables LSP syntax highlighting
        -- if treesitter highlighting is active.
        -- vim.highlight.priorities.semantic_tokens = 95
    end,
}
