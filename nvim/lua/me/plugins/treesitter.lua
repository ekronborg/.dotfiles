return {
    "nvim-treesitter/nvim-treesitter",
    -- enabled = false,
    lazy = false,
    build = ":TSUpdate",
    -- version = false,
    -- event = { "BufReadPost", "BufNewFile" },
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
            "jinja",
            "jinja_inline",
            "json",
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

        -- This basically does ':set syntax=markdown'. Using treesitter, some highlighting is missing, for example,
        -- strike through, bold, and italic.  Without treesitter or polyglot, strike trough links to 'htmlStrike',
        -- so I think it can also be set directly via vim.api.nvim_set_hl.
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = {
                "markdown",
                "bitbake",
                "vimdoc",
            },
        },

        indent = {
            enable = true,
            disable = {
                "yaml.gitlab",
            },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter").install(opts.ensure_installed)

        -- https://github.com/MeanderingProgrammer/treesitter-modules.nvim#implementing-yourself
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                local buf = ev.buf
                local filetype = ev.match

                local lang = vim.treesitter.language.get_lang(filetype) or filetype
                if not vim.treesitter.language.add(lang) then
                    return
                end

                pcall(vim.treesitter.start, buf, lang)

                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                -- See :h vim.treesitter.start() for syntax aka "additional_vim_regex_highlighting".
                -- vim.bo[buf].syntax = 'on'
            end,

            -- config = function(_, opts)
            --     require("nvim-treesitter").install(opts.ensure_installed)
            --
            --     vim.api.nvim_create_autocmd("FileType", {
            --         callback = function(ev)
            --             local buf = ev.buf
            --             local filetype = ev.match
            --
            --             if not vim.tbl_contains(opts.ensure_installed, filetype) then
            --                 return
            --             end
            --
            --             local lang = vim.treesitter.language.get_lang(filetype) or filetype
            --             pcall(vim.treesitter.start, buf, lang)
            --
            --             vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            --         end,
        })

        -- require("nvim-treesitter").setup(opts)
    end,

    -- config = function(_, opts)
    --     require("nvim-treesitter.configs").setup(opts)
    --     -- See https://github.com/NvChad/NvChad/issues/1907 and ':h vim.highlight.priorities'.
    --     -- Treesitter highlighting has priority 100, so this effectively disables LSP syntax highlighting
    --     -- if treesitter highlighting is active.
    --     -- vim.highlight.priorities.semantic_tokens = 95
    -- end,
}
