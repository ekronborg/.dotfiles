-- Integrated terminal emulator. The Git vim-fugitive plugin is messed up with these settings
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

local group = vim.api.nvim_create_augroup("neovim_terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    group = group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.keymap.set("n", "<C-c>", "i<C-c>")
        vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = none, guibg = none })
        -- vim.cmd("highlight ExtraWhitespace ctermbg=none guibg=none")
        vim.cmd("startinsert")
    end,
})
