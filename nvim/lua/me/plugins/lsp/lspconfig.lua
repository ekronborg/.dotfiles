return {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
        "saghen/blink.cmp",
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

                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, opts)
            end,
        })

        -- Use a loop to conveniently call "setup" on multiple servers
        local servers = {
            "bashls",
            "clangd",
            "gitlab_ci_ls",
            "pyright", -- ruff_lsp also exists
            "rust_analyzer",
            "systemd_ls",
            -- "dockerls",
            -- "marksman",
            -- "texlab",
            -- "vimls",
            -- "yamlls",
        }

        -- TODO: Can be dropped when migrated to the LSP setup introduced in 0.11 with
        -- vim.lsp.config(), vim.lsp.enable() and server configurations in ~/.config/nvim/lsp/.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

        local lspconfig = require("lspconfig")
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                -- on_attach = my_custom_on_attach,
                capabilities = capabilities,
            })
        end

        -- Prefer Tree-sitter syntax highlighting instead of LSP semantic highlighting
        lspconfig["bitbake_ls"].setup({
            on_attach = function(client)
                -- https://github.com/NvChad/NvChad/issues/1907
                client.server_capabilities.semanticTokensProvider = vim.NIL
            end,
        })

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

        -- NOTE: ansiblels requires ft=yaml.ansible
        lspconfig["ansiblels"].setup({
            capabilities = capabilities,
            settings = { -- https://ansible.readthedocs.io/projects/vscode-ansible/#configuration
                ansible = {
                    ansible = {
                        useFullyQualifiedCollectionNames = false,
                    },
                },
                redhat = {
                    telemetry = { enabled = false },
                },
            },
        })

        -- General settings
        vim.diagnostic.config({
            underline = false,
            virtual_text = { current_line = true },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
            jump = {
                float = true,
            },
        })
    end,
}
