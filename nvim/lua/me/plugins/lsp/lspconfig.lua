return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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

        local servers = {
            "ansiblels",
            "bashls",
            "clangd",
            "gitlab_ci_ls",
            "lua_ls",
            "pyright", -- ruff_lsp also exists
            "rust_analyzer",
            "systemd_ls",
        }

        -- Prepend tools installed by Mason to Neovims $PATH
        vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "none" },
                    },
                },
            },
        })

        vim.lsp.config("ansiblels", {
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

        vim.lsp.enable(servers)

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

        -- local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
        -- -- Prefer Tree-sitter syntax highlighting instead of LSP semantic highlighting
        -- local lspconfig = require("lspconfig")
        -- lspconfig["bitbake_ls"].setup({
        --     on_attach = function(client)
        --         -- https://github.com/NvChad/NvChad/issues/1907
        --         client.server_capabilities.semanticTokensProvider = vim.NIL
        --     end,
        -- })
    end,
}
