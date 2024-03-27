return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "j-hui/fidget.nvim",
    },
    config = function()
        -- TODO: is this useful
        require("fidget").setup({})

        -- Global mappings
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        -- <leader> cannot be used either here or in LspAttach. I'm unsure why.
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }

                -- -- Using vim.lsp
                -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                -- vim.keymap.set({"n", "v"}, "<space>ca", vim.lsp.buf.code_action, opts)
                -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                -- vim.keymap.set("n", "<space>h", vim.lsp.buf.signature_help, opts)

                -- Using Telescope
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
                vim.keymap.set("n", "gd", builtin.lsp_definitions)
                vim.keymap.set("n", "gi", builtin.lsp_implementations)
                vim.keymap.set("n", "gr", builtin.lsp_references)
                vim.keymap.set("n", "<space>D", builtin.lsp_type_definitions)
                vim.keymap.set("n", "<space>ds", builtin.lsp_document_symbols)
                vim.keymap.set("n", "<space>ws", builtin.lsp_workspace_symbols)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action)
                vim.keymap.set("n", "K", vim.lsp.buf.hover)
                vim.keymap.set("n", "<space>h", vim.lsp.buf.signature_help)
            end,
        })

        -- Use a loop to conveniently call "setup" on multiple servers
        local servers = {
            "pyright", -- ruff_lsp also exists
            -- "lua_ls",
            "bashls",
            "clangd",
            -- "marksman",
            -- "texlab",
            -- "yamlls",
            -- "vimls",
            -- "ansiblels",
            -- "dockerls",
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
        local lspconfig = require("lspconfig")

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                -- on_attach = my_custom_on_attach,
                capabilities = capabilities,
            })
        end

        -- Turn off "Undefied global `vim`" noise
        lspconfig["lua_ls"].setup({
            -- on_attach = my_custom_on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "none" },
                    },
                },
            },
        })

        -- Turn off some stuff
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = false,
            update_in_insert = false,
            severity_sort = false,
            -- float = {
            --     border = "rounded",
            -- },
        })

        -- Show icons in the gutter instead of letters
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- -- Configure borders for LspInfo ui
        -- require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
}
