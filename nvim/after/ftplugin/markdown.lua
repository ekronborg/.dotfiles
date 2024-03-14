vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.textwidth = 120
vim.opt_local.colorcolumn = "+1"

-- vim.opt_local.formatprg = "prettier --parser markdown --prose-wrap always --print-width 120"
-- vim.keymap.set({"n", "v"}, "<leader>f", "gggqG", {silent = true})
-- format_file = function()
--     local save_cursor = vim.fn.getpos(".")
--     vim.cmd("gggqG")
--     vim.fn.setpos(".", save_cursor)
-- end
-- vim.cmd("command! format_md :lua format_file()<cr>")
-- vim.keymap.set({"n", "v"}, "<leader>f", ":lua format_file()<cr>", {silent = true})
