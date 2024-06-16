return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "VeryLazy", "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
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

        indent = { enable = true },

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
        },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
