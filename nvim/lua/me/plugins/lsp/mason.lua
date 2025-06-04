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
    opts = {
        ui = {
            backdrop = 100,
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
        ensure_installed = {
            "ansible-language-server",
            "ansible-lint",
            "bash-language-server",
            "black",
            "clangd",
            "flake8",
            "gitlab-ci-ls",
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
            "systemd-language-server",
            "vint",
            "yamllint",
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)
        -- Since mason-lspconfig cannot install linters and formatters, mason-tool-installer can be used instead.
        -- However, it does not work with lazy loading. Therefore, this hack can be used to install LSP servers,
        -- linters and formatters with mason-lspconfig instead by using the Mason registry. This comes with the
        -- side effect of increasing the loading time significantly. The implementation is based on
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39#issuecomment-1985022867
        -- and the one in LazyVim, but mine is simplified
        local registry = require("mason-registry")
        for _, tool in ipairs(opts.ensure_installed) do
            local package = registry.get_package(tool)
            if not package:is_installed() then
                package:install()
                -- vim.notify(string.format("Installing %s...", package.name))
            end
        end
    end,
}
