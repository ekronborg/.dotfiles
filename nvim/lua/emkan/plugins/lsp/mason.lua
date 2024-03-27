return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- Mason itself
        require("mason").setup({
            -- ui = { border = "rounded" },
        })

        -- Install LSP servers
        require("mason-lspconfig").setup({
            ensure_installed = {
                "pyright", -- ruff_lsp also exists
                "lua_ls",
                "bashls",
                "clangd",
                -- "marksman",
                -- "texlab",
                -- "yamlls",
                -- "vimls",
                -- "ansiblels",
                -- "dockerls",
            },
        })

        -- Install linters and formartters
        require("mason-tool-installer").setup({
            "prettier",
            "stylua",
            "shfmt",
            "isort",
            "black",
        })
    end,
}
