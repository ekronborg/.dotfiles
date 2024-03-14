local conform = require("conform")

-- Install these formaters with Mason
conform.setup({
    formatters_by_ft = {
        markdown = { "prettier" },
        vimwiki = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        lua = { "stylua" },
        sh = { "shfmt" },
        python = { "isort", "black" }, -- run isort first and then black
        ["_"] = { "trim_whitespace", "trim_newlines" },
    },
})

vim.keymap.set({ "n", "v" }, "<F5>", function()
    conform.format()
end)

-- -- https://github.com/stevearc/conform.nvim/issues/316
-- -- Formats buffers using the attached language server clients or using `conform` as a fallback.
-- local function format()
--     local buf_clients = vim.lsp.buf_get_clients()
--     -- Check LSP clients that support formatting
--     for _, client in pairs(buf_clients) do
--         if client.supports_method('textDocument/formatting') then
--             vim.lsp.buf.format { async = true }
--             return
--         end
--     end
--     -- Fallback on conform
--     require('conform').format()
-- end
-- vim.keymap.set("n", "<leader>f", format)
