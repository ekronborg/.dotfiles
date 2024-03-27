return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local telescope = require("telescope")

        telescope.setup({
            pickers = {
                find_files = {
                    find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--follow", "--exclude", ".git" },
                },
            },
        })

        -- Increase performance
        telescope.load_extension("fzf")

        -- Keymaps. TIP: C-q will populate the quickfix list with the current contents
        local builtin = require("telescope.builtin")
        local themes = require("telescope.themes")
        local keymap = vim.keymap

        keymap.set("n", "<C-p>", builtin.find_files, {})
        keymap.set("n", "<C-f>", builtin.live_grep, {})
        keymap.set("n", "<leader>b", builtin.buffers, {})
        keymap.set("n", "<leader>d", builtin.diagnostics, {})

        vim.keymap.set("n", "<leader>p", function()
            builtin.find_files({ cwd = "~/notes", prompt_title = "Search notes" })
        end)

        vim.keymap.set("n", "<leader>f", function()
            builtin.live_grep({ cwd = "~/notes", prompt_title = "Grep notes" })
        end)
    end,
}
