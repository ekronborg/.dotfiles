-- Yes, a plugin to show trailing whitespace is absolutely overkill. In Neovim, floating windows are used a lot
-- for, for example, Lazy, LspInfo, Mason, LSP diagnostics etc. With my old vimscript solution,
-- there would be shown trailing whitespace in these windows. This plugin mostly gets rid of that,
-- but trailing whitespace is still shown in some cases it does not make sense.

require("mini.trailspace").setup()
vim.cmd("command! Trim :lua MiniTrailspace.trim()<cr>")
