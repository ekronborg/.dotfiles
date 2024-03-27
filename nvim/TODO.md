## TODO

- Test `tree-sitter` and its BitBake integration: https://github.com/tree-sitter-grammars/tree-sitter-bitbake
- BitBake LSP? See vscode marketplace

## Potential plugins to try

- https://github.com/folke/trouble.nvim
- https://github.com/folke/zen-mode.nvim
- https://github.com/j-hui/fidget.nvim
- https://github.com/rafamadriz/friendly-snippets
- https://github.com/stevearc/aerial.nvim
- https://github.com/tpope/vim-eunuch
- https://github.com/tpope/vim-surround
- https://github.com/nvim-neo-tree/neo-tree.nvim
- https://github.com/echasnovski?tab=repositories&q=&type=&language=&sort=stargazers

## Get highlight group

Use `:Inspect` or `:Inspect!` to get the `highlight` group(s) under the cursor.

https://vi.stackexchange.com/questions/39781/how-to-get-the-highlight-group-of-the-word-under-the-cursor-in-neovim-with-trees

## Opts in Lazy install

Cleaner way to setup plugins?

```lua
    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },
```
