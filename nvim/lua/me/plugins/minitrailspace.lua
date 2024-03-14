-- Yes, a plugin to show trailing whitespace is absolutely overkill. In Neovim, floating windows are used a lot
-- for, for example, Lazy, LspInfo, Mason, LSP diagnostics etc. With my old vimscript solution,
-- there would be shown trailing whitespace in these windows. This plugin mostly gets rid of that,
-- but trailing whitespace is still shown in some cases it does not make sense.
return {
    "echasnovski/mini.trailspace",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mini.trailspace").setup()
        vim.cmd("command! Trim :lua MiniTrailspace.trim()<cr>")
    end,
}

-- Keeping these old implementations here for documentation

-- -- https://github.com/lucasvianav/nvim/blob/62ac5c2aa8abb25094d7d896c3b58a0936c13984/lua/functions/utilities.lua#L39-L48
-- trim_trailing_whitespace = function()
--     local save_cursor = vim.fn.getpos(".")
--     vim.cmd([[keeppatterns %s/\s\+$//e]])
--     vim.fn.setpos(".", save_cursor)
-- end

-- -- https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/trailspace.lua
-- trim_trailing_whitespace = function()
--     local curpos = vim.api.nvim_win_get_cursor(0)
--     vim.cmd([[keeppatterns %s/\s\+$//e]])
--     vim.api.nvim_win_set_cursor(0, curpos)
-- end

-- vim.cmd("command! Trim :lua trim_trailing_whitespace()<cr>")
