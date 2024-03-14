return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
    },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- Mason itself
        require("mason").setup({
            ui = {
                -- border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- Install LSP servers
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "clangd",
                "lua_ls",
                "pyright", -- ruff_lsp also exists
                "rust_analyzer",
                -- "ansiblels",
                -- "dockerls",
                -- "marksman",
                -- "texlab",
                -- "vimls",
                -- "yamlls",
            },
        })

        -- Install linters and formatters
        require("mason-tool-installer").setup({
            ensure_installed = {
                "black",
                "flake8",
                "vint",
                "isort",
                "jsonlint",
                "prettier",
                "shfmt",
                "stylua",
                "yamllint",
            },
        })
    end,
}
