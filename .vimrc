set nocompatible          " Required for Vi(improved) to work
filetype plugin indent on " Required
syntax on                 " Enable syntax highlightning
"------------------------------------------------------------------------------
" Plugins 
"------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
call plug#end()

"------------------------------------------------------------------------------
" Basic settings
" TODO: set up CoC or move to Neovim and use built-in LSP 
"------------------------------------------------------------------------------
set ruler                            " Show line number, column number, and %
set path+=**                         " Searches current directory recursively (incl. subfolders)
set wildmenu                         " Display all matches when tab complete
set wildmode=longest,list,full       " Better tab completion
set backspace=indent,eol,start       " Make delete act normal
set laststatus=0                     " 2 = always show, 0 = never show
set expandtab                        " Use spaces instead of tabs
set smarttab                         " Auto tabbing
set autoindent                       " Automatical indentation of new lines
set shiftwidth=4                     " One tab equals four spaces
set tabstop=4                        " One tab equals four spaces
set nohlsearch                       " Disable highlight search matches
set incsearch                        " Incremental searching
set ignorecase                       " Searches are case sensitive only when term has at least one capital
set noshowmatch                      " Disable highlighting of matching brackets
set hidden                           " Required to keep multiple buffers open
set nobackup                         " Disable automatic backup files
set noswapfile                       " Disable swapfile
set scrolloff=5                      " Always show 5 lines when scrolling
set ttimeoutlen=10                   " Lower timeout for commands (faster escape to normal mode)
set updatetime=300                   " Default is 4000 ms
set splitbelow                       " Split below
set splitright                       " Split right
set t_md=                            " Disable all bold font
set omnifunc=syntaxcomplete#Complete " Enable omnifunc (C-x C-o)
set fillchars+=vert:│                " Solid line instead of dashed line
set clipboard=unnamedplus            " Use system clipboard

"------------------------------------------------------------------------------
" Colorscheme settings
"------------------------------------------------------------------------------
if has('nvim') || has('termguicolors')
    set termguicolors
endif
set background=dark
" colorscheme gruvbox
" let g:gruvbox_material_background='hard'
" let g:gruvbox_material_palette='mix'
colorscheme gruvbox-material

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
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

" Move in long lines
nnoremap j gj
nnoremap k gk

" Keeping the cursor centered (https://www.youtube.com/watch?v=hSHATqh8svM)
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" Toggle fuzzy searching and buffers
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <C-f> :Rg 

"------------------------------------------------------------------------------
" Use ripgrep instead of default vimgrep
"------------------------------------------------------------------------------
set grepprg=rg\ --vimgrep

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

" Toggle explorer with leader+e
" 'v': vertical split, 'o': horizontal split, 't': new tab
noremap <silent> <leader>e  :call ToggleNetrw()<CR>
