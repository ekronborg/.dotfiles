## Potential plugins to try

- https://github.com/folke/trouble.nvim
- https://github.com/folke/zen-mode.nvim
- https://github.com/debugloop/telescope-undo.nvim
- https://github.com/rafamadriz/friendly-snippets
- https://github.com/stevearc/aerial.nvim
- https://github.com/stevearc/dressing.nvim
- https://github.com/tpope/vim-eunuch
- https://github.com/tpope/vim-surround
- https://github.com/nvim-neo-tree/neo-tree.nvim
- https://github.com/sindrets/diffview.nvim
- https://github.com/echasnovski?tab=repositories&q=&type=&language=&sort=stargazers
- https://github.com/glts/vim-radical
- https://github.com/utilyre/barbecue.nvim
- https://github.com/nvim-treesitter/nvim-treesitter-context
- https://github.com/dgox16/devicon-colorscheme.nvim

## Nvim 0.10

- Good overview by core maintainer: https://gpanders.com/blog/whats-new-in-neovim-0.10/
- See the section about default keymaps in 0.10: https://github.com/neovim/nvim-lspconfig
- `:lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())`

## Future release

Commit 688860741589 ("feat(lsp): add more LSP defaults (#28500)") adds:

- `crn` for rename
- `crr` for code actions
- `gr` for references
- `<C-S>` (in Insert mode) for signature help

Note that this commit was reverted in bb032d952bfc ("revert: default LSP mappings (#28649)") for the v0.10.0 release.

## Telescope filename_first

When commit a4432dfb9b0b ("feat(entry_maker): add 'filename_first' option for path_display (#3010)") is merged into the
`0.1.x` branch, add

```lua
defaults = {
    path_display = { filename_first = true },
},
```

## BitBake LSP

See commit 6a6a297686b6 ("feat: add bitbake-language-server (#3151)") in the nvim-lspconfig repo.

For now, the LSP is installed via `npm` like described in the official repo:
https://github.com/yoctoproject/vscode-bitbake/blob/main/server/README.md

If/when it becomes available in Mason, nuke it from `npm`.

```bash
# Why is bitbake-language-server installed as language-server-bitbake?
$ sudo npm install -g bitbake-language-server
$ which language-server-bitbake
/usr/local/bin/language-server-bitbake
```

Fix this by overwriting `cmd` in the configuration for nvim-lspconfig:

```lua
lspconfig["bitbake_language_server"].setup({
    cmd = { 'language-server-bitbake', '--stdio' },
    -- single_file_support = true,
})
```
