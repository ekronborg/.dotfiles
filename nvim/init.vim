filetype plugin indent on
"------------------------------------------------------------------------------
" Plugins
"------------------------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'kergoth/vim-bitbake'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
call plug#end()

"------------------------------------------------------------------------------
" General settings
"------------------------------------------------------------------------------
set path+=**
set wildmode=longest,list,full
set laststatus=3
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
set noruler
set number
set signcolumn=number
set cursorline
set tags=./tags;/

"------------------------------------------------------------------------------
" Color settings
"------------------------------------------------------------------------------
" https://github.com/tmux/tmux/issues/1246
" Neovim does not have 't_xx' options, see ':h t_xx'. Thus, it is only
" nessescary to set 'termguicolors'
let g:gruvbox_invert_selection = '0'
let g:gruvbox_sign_column = 'none'
set termguicolors
colorscheme gruvbox

" Highlight only current line
hi CursorLine guibg=none
" hi CursorLineNr guibg=none
hi CursorLineNr guibg=none guifg=#ebdbb2

" Highlight trailing whitespace (https://vim.fandom.com/wiki/Highlight_unwanted_spaces)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Visual feedback when yanking (https://neovim.io/doc/user/lua.html#lua-highlight)
au TextYankPost * silent! lua vim.highlight.on_yank()

"------------------------------------------------------------------------------
" Vimwiki
"------------------------------------------------------------------------------
" - cheatsheet https://gist.github.com/drkarl/4c503bccb62558dc85e8b1bc0f29e9cb
" - https://github.com/vimwiki/vimwiki#changing-wiki-syntax

let g:vimwiki_list = [{'path': '~/notes/',
                      \ 'syntax': 'markdown', 'filetype': 'markdown', 'ext': '.md'}]

let g:vimwiki_global_ext = 0
let g:vimwiki_auto_chdir = 1
" let g:vimwiki_conceal_pre = 1

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

" Keeping the cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" Keep selection when moving lines up and down
vnoremap <silent> <S-j> :m '>+1<CR>gv=gv
vnoremap <silent> <S-k> :m '<-2<CR>gv=gv

" Move in long lines
nnoremap j gj
nnoremap k gk

" Navitgate the quickfix list
nnoremap <C-k> <cmd>cnext<cr>zz
nnoremap <C-j> <cmd>cprev<cr>zz

" Fuzzy find (Telescope). TIP: C-q will populate the quickfix list with the current contents
" nnoremap <C-p> <CMD>lua require'telescope-config'.project_files()<CR>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
" nnoremap <leader>d <cmd>Telescope diagnostics<cr>

" Delete to blackhole register
vnoremap <leader>d "_d

" Open tag in new tab
nnoremap <silent> <leader>t :tab tag <c-r><c-w><cr>

"------------------------------------------------------------------------------
" Autocommands
"------------------------------------------------------------------------------
" Terminal stuff
tnoremap <Esc> <C-\><C-n>
augroup neovim_terminal
    autocmd!
    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert
    " Disables number lines on terminal buffers
    autocmd TermOpen * set nonumber norelativenumber
    " allows you to use Ctrl-c on terminal window
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
    " No highlight
    autocmd TermOpen * highlight ExtraWhitespace ctermbg=none guibg=none
augroup END

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
let g:netrw_winsize=25

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
  require('null-ls-config')
  require('telescope-config')
  require('lualine-config')
  require('lastplace')
EOF
