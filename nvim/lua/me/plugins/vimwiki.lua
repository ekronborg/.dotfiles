return {
    "vimwiki/vimwiki",
    enabled = false,
    ft = { "vimwiki", "markdown" },
    init = function() -- https://github.com/LazyVim/LazyVim/discussions/258
        vim.g.vimwiki_list = {
            { path = "~/notes", syntax = "markdown", filetype = "markdown", ext = "md" },
            -- { path = "~/notes", filetype = "markdown", ext = "md" },
        }
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_auto_chdir = 1
        -- vim.g.vimwiki_conceal_pre = 1
    end,

    config = function()
        -- syntax is not set to vimwiki when lazy loaded, so set it explicitly.
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufWinEnter" }, {
            pattern = "*.md",
            command = "set syntax=vimwiki",
        })
    end,
}

-- Note that the default keybinds does not work when lazy loading.
