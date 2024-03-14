-- See :h vim.filetype.add() and /usr/share/nvim/runtime/lua/vim/filetype.lua

vim.filetype.add({
	extension = {
		config = "conf", -- *.config files used for genimage should be detected as conf
		service = "systemd", -- *.service files in Yocto repo is not detected as systemd
	},
})
