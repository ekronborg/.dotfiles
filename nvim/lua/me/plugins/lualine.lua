return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local function lsp_clients()
            local bufnr = vim.api.nvim_get_current_buf()

            local clients = vim.lsp.buf_get_clients(bufnr)
            if next(clients) == nil then
                return ""
            end

            local tbl = {}
            for _, client in ipairs(clients) do
                table.insert(tbl, client.name)
            end

            -- return " " .. table.concat(tbl, ",")
            return " " .. table.concat(tbl, ",")
        end

        require("lualine").setup({
            options = {
                -- component_separators = "",
                -- section_separators = { left = "", right = "" },
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
                disabled_filetypes = {
                    "man",
                },
            },
            sections = {
                lualine_b = { "branch", "diff", lsp_clients, "diagnostics" },
            },
        })
    end,
}
