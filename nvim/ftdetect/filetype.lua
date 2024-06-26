-- See :h vim.filetype.add() and /usr/share/nvim/runtime/lua/vim/filetype.lua

vim.filetype.add({
    extension = {
        -- Example of a global filetype mapping
        -- service = "systemd", -- *.service files in Yocto repo is not detected as systemd
    },
    pattern = { -- https://neovim.io/doc/user/luaref.html#lua-patterns
        [".*/meta%-.*/.*%.service"] = "systemd",
        [".*/meta%-.*/.*%.inc"] = "bitbake",
        [".*/recipes%-.*/.*%.inc"] = "bitbake",
        [".*/conf/.*%.conf"] = "bitbake",
        [".*/meta%-.*/documentation/.*%.inc"] = "rst",
        [".*/recipes%-images/.*%.config"] = "conf",
    },
})
