return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "folke/neodev.nvim", opts = {} },
        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
        { "j-hui/fidget.nvim", opts = {} },
        "williamboman/mason.nvim",
    },
    config = function()
        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, opts)
            end,
        })

        -- Use a loop to conveniently call "setup" on multiple servers
        local servers = {
            "bashls",
            "clangd",
            "pyright", -- ruff_lsp also exists
            "rust_analyzer",
            -- "dockerls",
            -- "marksman",
            -- "texlab",
            -- "vimls",
            -- "yamlls",
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

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    -- Turn off "Undefied global `vim`" noise
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

        -- Configure rounded borders
        -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        --     border = "rounded",
        -- })
        -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {
        --     border = "rounded",
        -- })
        -- require("lspconfig.ui.windows").default_options.border = "rounded" -- LspInfo UI is special
    end,
}
