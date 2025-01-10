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
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- Since mason-lspconfig cannot install linters and formatters, mason-tool-installer can be used instead.
        -- However, it does not work with lazy loading. Therefore, this hack can be used to install LSP servers,
        -- linters and formatters with mason-lspconfig instead by using the Mason registry. This comes with the
        -- side effect of increasing the loading time significantly. The implementation is based on
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39#issuecomment-1985022867
        -- and the one in LazyVim, but mine is simplified
        local ensure_installed = {
            "ansible-language-server",
            "ansible-lint",
            "bash-language-server",
            "black",
            "clangd",
            "flake8",
            "isort",
            "jsonlint",
            "language-server-bitbake",
            "lua-language-server",
            "oelint-adv",
            "prettier",
            "pyright", -- ruff_lsp also exists
            "rstcheck",
            "rust-analyzer",
            "shellcheck",
            "shfmt",
            "stylua",
            "vint",
            "yamllint",
        }

        -- Ensure tools are installed
        local registry = require("mason-registry")
        for _, tool in ipairs(ensure_installed) do
            local package = registry.get_package(tool)
            if not package:is_installed() then
                package:install()
                -- vim.notify(string.format("Installing %s...", package.name))
            end
        end
    end,
}
