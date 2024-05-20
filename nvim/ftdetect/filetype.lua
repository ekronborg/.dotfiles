-- See :h vim.filetype.add() and /usr/share/nvim/runtime/lua/vim/filetype.lua

vim.filetype.add({
    extension = {
        config = "conf", -- *.config files used for genimage should be detected as conf
        service = "systemd", -- *.service files in Yocto repo is not detected as systemd
    },
    pattern = { -- https://neovim.io/doc/user/luaref.html#lua-patterns
        [".*/conf/.*%.conf"] = "bitbake",
        [".*/meta%-.*/.*%.inc"] = "bitbake",
        [".*/meta%-.*/documentation/.*%.inc"] = "rst",
        [".*/recipes%-images/.*%.config"] = "conf",
    },
})
