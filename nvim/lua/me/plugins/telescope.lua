return {
    "nvim-telescope/telescope.nvim",
    keys = {
        -- General
        { "<C-p>", "<cmd>Telescope find_files<cr>", mode = "n" },
        { "<C-f>", "<cmd>Telescope live_grep<cr>", mode = "n" },
        { "<leader>b", "<cmd>Telescope buffers<cr>", mode = "n" },
        { "<leader>d", "<cmd>Telescope diagnostics<cr>", mode = "n" },

        -- LSP
        { "gd", "<cmd>Telescope lsp_definitions<cr>", mode = "n" },
        { "gi", "<cmd>Telescope lsp_implementations<cr>", mode = "n" },
        { "gr", "<cmd>Telescope lsp_references<cr>", mode = "n" },
        { "<leader>D", "<cmd>Telescope lsp_type_definitions<cr>", mode = "n" },
        { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", mode = "n" },
        { "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", mode = "n" },

        -- Notes
        {
            "<leader>wp",
            function()
                require("telescope.builtin").find_files({ cwd = "~/notes", prompt_title = "Search notes" })
            end,
        },

        {
            "<leader>wf",
            function()
                require("telescope.builtin").live_grep({ cwd = "~/notes", prompt_title = "Search notes" })
            end,
        },

        -- Misc
        {
            "<leader>ss",
            function()
                require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({
                    prompt_title = "",
                    layout_config = {
                        height = 0.25,
                        width = 0.25,
                    },
                }))
            end,
        },
    },
    cmd = { "Telescope" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                -- requires commit a4432dfb9b0b ("feat(entry_maker): add 'filename_first' option for path_display (#3010)")
                path_display = { "filename_first" },
            },
            pickers = {
                find_files = {
                    find_command = {
                        "fd",
                        "--type",
                        "f",
                        "--strip-cwd-prefix",
                        "--hidden",
                        "--follow",
                        "--exclude",
                        ".git",
                    },
                },
            },
        })

        -- Increase performance
        telescope.load_extension("fzf")
    end,
}
