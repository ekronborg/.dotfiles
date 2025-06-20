-- https://neovim.io/doc/user/lua.html#vim.highlight
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_augroup("GitlabYaml", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = "GitlabYaml",
    pattern = "*.gitlab-ci*.{yml,yaml}",
    callback = function()
        vim.bo.filetype = "yaml.gitlab"
    end,
})

vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "MarkdownSettings",
    pattern = "markdown",
    callback = function()
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
        if buftype ~= "nofile" then
            vim.opt_local.spell = true
            vim.opt_local.spelllang = "en_us"
            vim.opt_local.textwidth = 120
            vim.opt_local.colorcolumn = "+1"
        end
    end,
})

-- https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md#-examples
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
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
