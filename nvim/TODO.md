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
- https://github.com/ibhagwan/fzf-lua

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
