-- Highlight trailing whitespace (https://vim.fandom.com/wiki/Highlight_unwanted_spaces)
-- Must be sourced before colors.lua!
-- This shows trailing whitespace in floating windows (Lazy, LspInfo, Mason, LSP diagnostics etc).
-- Using mini.trailspace somewhat solves this, but it still shows somewhere.
vim.cmd([[
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=Red guibg=Red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
]])

-- -- https://github.com/lucasvianav/nvim/blob/62ac5c2aa8abb25094d7d896c3b58a0936c13984/lua/functions/utilities.lua#L39-L48
-- trim_trailing_whitespace = function()
--     local save_cursor = vim.fn.getpos(".")
--     vim.cmd([[keeppatterns %s/\s\+$//e]])
--     vim.fn.setpos(".", save_cursor)
-- end

-- https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/trailspace.lua
trim_trailing_whitespace = function()
    local curpos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, curpos)
end

vim.cmd("command! Trim :lua trim_trailing_whitespace()<cr>")

-- -- Grouping autocommands in in Lua. What a mess
-- vim.fn.matchadd("ExtraWhitespace", [[/\s\+$/]])
-- local mygroup = vim.api.nvim_create_augroup("extraws", { clear = true })
-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--     pattern = "*",
--     group = mygroup,
--     command = "highlight ExtraWhitespace ctermbg=Red guibg=Red",
-- })
-- vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWinLeave" }, {
--     pattern = "*",
--     group = mygroup,
--     command = [[match ExtraWhitespace /\s\+$/]],
-- })
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--     pattern = "*",
--     group = mygroup,
--     command = [[match ExtraWhitespace /\s\+\%#\@<!$/]],
-- })
-- vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
--   pattern = "*",
--   group = "extraws",  -- equivalent to group=mygroup
--   command = "call clearmatches()",
-- })
