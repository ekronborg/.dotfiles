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
        -- -- vim.lsp
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        -- vim.keymap.set({"n", "v"}, "<space>ca", vim.lsp.buf.code_action, opts)
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- vim.keymap.set("n", "<space>h", vim.lsp.buf.signature_help, opts)

        -- Telescope
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

-- Install LSP servers via Mason
-- Note: this plugin uses the lspconfig server names in the APIs it exposes - not mason.nvim package names.
-- Therefore, not all packages can be automatically installed. See this list for mappings:
--     https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
local servers = {
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
}

require("mason").setup({
    -- ui = { border = "rounded" },
})
require("mason-lspconfig").setup({ ensure_installed = servers })

-- Use a loop to conveniently call "setup" on multiple servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    })
end

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
