set nocompatible          " Required for Vi(improved) to work
filetype plugin indent on " Required
syntax on                 " Enable syntax highlightning
"------------------------------------------------------------------------------
" Plugins 
"------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
"Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-surround'
call plug#end()

"------------------------------------------------------------------------------
" Basic settings (set up CoC or move to Neovim and use their LSP)
"------------------------------------------------------------------------------
"set number relativenumber      " Show relative line numbers
set ruler                      " Show line number, column number, and % in statusline
set path+=**                   " Searches current directory recursively
set wildmenu                   " Display all matches when tab complete
set wildmode=longest,list,full " Better tab completion
set mouse=a                    " Enable mouse
set backspace=indent,eol,start " Make delete act normal
set clipboard=unnamedplus      " Copy/paste between vim and other programs (use mouse middle-click)
set laststatus=2               " Always show statusline
set expandtab                  " Use spaces instead of tabs
set smarttab                   " Auto tabbing
set autoindent                 " Automatical indentation of new lines
set shiftwidth=4               " One tab equals four spaces
set tabstop=4                  " One tab equals four spaces
set nohlsearch                 " Disable highlight search matches
set incsearch                  " Incremental searching
set ignorecase                 " Searches are case sensitive only when term has at least one capital
set noshowmatch                " Disable highlighting of matching brackets
set hidden                     " Required to keep multiple buffers open
set nobackup                   " Disable automatic backup files
set noswapfile                 " Disable swapfile
set scrolloff=5                " Always show 8 lines when scrolling
set ttimeoutlen=10             " Lower timeout for commands (faster escape to normal mode)
set splitbelow                 " Split below
set splitright                 " Split right
let loaded_matchparen = 1      " Disable matching parentheses (built-in plugin)
set t_md=                      " Disable all bold font
" set colorcolumn=110            " Show column at 110th column
" set fillchars+=vert:\          " Disable pipe as seperator for splits

"------------------------------------------------------------------------------
" Colorscheme settings
"------------------------------------------------------------------------------
set termguicolors   " Set 24-bit RGB color 
set background=dark " Dark background
colorscheme gruvbox

" Set absolute path and colorscheme of lightline. We also disable current mode
" via no showmode
"set noshowmode
"let g:lightline = {
"    \ 'active': {
"    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
"    \ },
"    \ 'colorscheme': 'gruvbox',
"    \ }

" Customize fzf colors to match colors set above
let g:fzf_colors =                                                                         
    \ { 'fg':      ['fg', 'Normal'],                                                           
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],                                                          
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],                             
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],                                       
    \ 'hl+':     ['fg', 'Statement'],                                                        
    \ 'info':    ['fg', 'PreProc'],                                                          
    \ 'border':  ['fg', 'Ignore'],                                                           
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],                                                     
    \ 'marker':  ['fg', 'Keyword'],                                                          
    \ 'spinner': ['fg', 'Label'],                                                            
    \ 'header':  ['fg', 'Comment'] } 

"------------------------------------------------------------------------------
" Remappings 
"------------------------------------------------------------------------------
" Map leader
let mapleader = " "
nnoremap Q :q<CR>

" Keep selection when shifting
vnoremap > >gv
vnoremap < <gv

" Make Y work like the rest of the capital letters
nnoremap Y y$ 

" Navigate between splits with CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move in long lines
nnoremap j gj
nnoremap k gk

" Keeping the cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz
"nnoremap G Gzz

" Toggle fuzzy searching and buffers
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

"------------------------------------------------------------------------------
" Set up netrw instead of Nerdtree (save a plugin)
"------------------------------------------------------------------------------
" Make it look cleaner like NERDTree
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

" Toggle explorer with leader+e (use 'v' and 'o' to open in splits)
noremap <silent> <leader>e  :call ToggleNetrw()<CR>

"------------------------------------------------------------------------------
" Zen mod
"------------------------------------------------------------------------------
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set nonumber! norelativenumber! " '!' toggles the option
        set laststatus=0
        set noshowcmd
        set noruler
    else
        let s:hidden_all = 0
        set number! relativenumber!
        set laststatus=2
    endif
endfunction

" Toggle zen mode via shift+h
nnoremap <silent> <leader>z  :call ToggleHiddenAll()<CR>
