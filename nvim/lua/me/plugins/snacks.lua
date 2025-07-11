return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        explorer = { enabled = true },
        image = { enabled = true },
        notifier = { enabled = true },
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    hidden = true,
                    win = {
                        list = {
                            keys = {
                                ["<C-t>"] = { "edit_tab", mode = { "n", "i" } },
                            },
                        },
                    },
                },
                grep = { hidden = true },
            },
            layouts = {
                default = {
                    layout = {
                        backdrop = false,
                    },
                },
            },
            win = {
                input = {
                    keys = {
                        ["<C-t>"] = { "edit_tab", mode = { "n", "i" } },
                    },
                },
            },
        },
    },
    keys = {
        -- stylua: ignore start
        -- { "<C-p>", function() Snacks.picker.smart({ hidden = true }) end },
        { "<C-p>", function() Snacks.picker.files({ hidden = true }) end },
        { "<C-f>", function() Snacks.picker.grep() end },
        { "<leader>b", function() Snacks.picker.buffers() end },
        { "<leader>sm", function() Snacks.picker.man() end },
        { "<leader>su", function() Snacks.picker.undo() end },
        { "<leader>e", function() Snacks.explorer() end },

        -- LSP
        { "<leader>d", function() Snacks.picker.diagnostics() end },
        { "<leader>bd", function() Snacks.picker.diagnostics_buffer() end },
        { "gd", function() Snacks.picker.lsp_definitions() end },
        { "gD", function() Snacks.picker.lsp_declarations() end },
        { "gi", function() Snacks.picker.lsp_implementations() end },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true },
        { "<leader>D", function() Snacks.picker.lsp_type_definitions() end },
        { "<leader>ds", function() Snacks.picker.lsp_symbols() end },
        { "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end },

        -- Notes
        { "<leader>wp", function() Snacks.picker.files({ cwd = "~/notes" }) end },
        { "<leader>wf", function() Snacks.picker.grep({ cwd = "~/notes" }) end },
        -- stylua: ignore end

        {
            "<leader>ss",
            function()
                Snacks.picker.spelling({
                    layout = {
                        preset = "select",
                        layout = {
                            width = 0.3,
                            min_width = 40,
                            height = 0.2,
                        },
                    },
                })
            end,
        },
    },
}
