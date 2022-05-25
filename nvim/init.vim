filetype plugin indent on
"------------------------------------------------------------------------------
" Plugins
"------------------------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'sevko/vim-nand2tetris-syntax'
Plug 'kergoth/vim-bitbake'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()

"------------------------------------------------------------------------------
" Basic settings
"------------------------------------------------------------------------------
set path+=**
set wildmode=longest,list,full
set laststatus=2
set noshowcmd
set expandtab
set shiftwidth=4
set tabstop=4
set ignorecase
set nobackup
set noswapfile
set scrolloff=5
set splitbelow
set splitright
set clipboard=unnamedplus
set guicursor=
set updatetime=300
set noshowmode

"------------------------------------------------------------------------------
" Color settings
"------------------------------------------------------------------------------
" https://github.com/tmux/tmux/issues/1246
if has('nvim') || exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
" let g:gruvbox_bold = '0'
let g:gruvbox_invert_selection = '0'
colorscheme gruvbox

" Highlight only current line
set number
set signcolumn=number
set cursorline
hi CursorLine guibg=none
hi CursorLineNr guibg=none guifg=#ebdbb2

" Highlight trailing whitespace (https://vim.fandom.com/wiki/Highlight_unwanted_spaces)
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Visual feedback when yanking (https://neovim.io/doc/user/lua.html#lua-highlight)
au TextYankPost * silent! lua vim.highlight.on_yank()

"------------------------------------------------------------------------------
" Remappings
"------------------------------------------------------------------------------
" Map leader
let mapleader = " "

" Map Q to something useful
nnoremap Q <cmd>q<cr>

" Keep selection when shifting
vnoremap > >gv
vnoremap < <gv

" Move in long lines
nnoremap j gj
nnoremap k gk

" Keeping the cursor centered (https://www.youtube.com/watch?v=hSHATqh8svM)
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" Telescope (<cmd> means :)
" nnoremap <C-p> <CMD>lua require'telescope-config'.project_files()<CR>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
" Tip: C-q will populate the quickfix list
" nnoremap <leader>d <cmd>Telescope diagnostics<cr>

" Delete to blackhole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Leave insert mode with <Esc> in terminal mode
tnoremap <Esc> <C-\><C-N>

"------------------------------------------------------------------------------
" Use ripgrep instead of default vimgrep
"------------------------------------------------------------------------------
set grepprg=rg\ --vimgrep

"------------------------------------------------------------------------------
" Useful command to trim trailing whitespace
"------------------------------------------------------------------------------
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

command! Trim :call TrimWhitespace()

"------------------------------------------------------------------------------
" Set up netrw instead of Nerdtree
"------------------------------------------------------------------------------
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=15

" Function to toggle explorer on and off
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Toggle explorer with leader+e
" 'v': vertical split, 'o': horizontal split, 't': new tab
noremap <silent> <leader>e  <cmd>call ToggleNetrw()<CR>

"------------------------------------------------------------------------------
" Lua stuff
"------------------------------------------------------------------------------
lua << EOF
  require('lsp-config')
  require('telescope-config')
  require('lualine-config')
EOF
