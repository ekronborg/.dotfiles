-- https://neovim.io/doc/user/lua.html#vim.highlight
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_augroup("GitlabYaml", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.gitlab-ci*.{yml,yaml}",
    callback = function()
        vim.bo.filetype = "yaml.gitlab"
    end,
})

-- -- Built-in terminal emulator. The Git vim-fugitive plugin is messed up with these settings
-- local group = vim.api.nvim_create_augroup("neovim_terminal", { clear = true })
-- vim.api.nvim_create_autocmd("TermOpen", {
--     pattern = "*",
--     group = group,
--     callback = function()
--         vim.opt_local.number = false
--         vim.opt_local.relativenumber = false
--         vim.keymap.set("n", "<C-c>", "i<C-c>")
--         vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = none, guibg = none })
--         -- vim.cmd("highlight ExtraWhitespace ctermbg=none guibg=none")
--         vim.cmd("startinsert")
--     end,
-- })

-- -- Highlight trailing whitespace (https://vim.fandom.com/wiki/Highlight_unwanted_spaces)
-- -- I think this must be sourced before gruvbox.lua
-- -- This shows trailing whitespace in floating windows (Lazy, LspInfo, Mason, LSP diagnostics etc).
-- -- Using mini.trailspace somewhat solves this, but it still shows somewhere.
-- vim.cmd([[
--     autocmd ColorScheme * highlight ExtraWhitespace ctermbg=Red guibg=Red
--     match ExtraWhitespace /\s\+$/
--     autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
--     autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
--     autocmd InsertLeave * match ExtraWhitespace /\s\+$/
--     autocmd BufWinLeave * call clearmatches()
-- ]])

-- -- Highlight trailing whitespace by grouping autocommands in in Lua. What a mess
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
