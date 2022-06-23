set nocompatible          " Required for Vi(improved) to work
filetype plugin indent on " Required
syntax on                 " Enable syntax highlightning
" Move viminfo from $HOME to $HOME/.vim
set viminfo+=n~/.vim/viminfo
"------------------------------------------------------------------------------
" Plugins
"------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
call plug#end()

"------------------------------------------------------------------------------
" Basic settings
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
set omnifunc=syntaxcomplete#Complete " Enable omnifunc (C-x C-o)
set fillchars+=vert:│                " Solid line instead of dashed line
set clipboard=unnamedplus            " Use system clipboard

" Highlight trailing whitespace (https://vim.fandom.com/wiki/Highlight_unwanted_spaces)
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"------------------------------------------------------------------------------
" Color settings
"------------------------------------------------------------------------------
" https://github.com/tmux/tmux/issues/1246
if has('nvim') || exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
set background=dark
let g:gruvbox_invert_selection = '0'
colorscheme gruvbox

" " Highlight only current line
" set number
" " set relativenumber
" set signcolumn=number
" set cursorline
" hi CursorLine guibg=NONE ctermbg=NONE
" hi CursorLineNr guibg=NONE ctermbg=NONE guifg=#ebdbb2

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

" Remap ctrl-l like in Neovim
nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>

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

" Delete to blackhole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Fuzzy searching
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <C-f> :Rg 

"------------------------------------------------------------------------------
" Autocommands
"------------------------------------------------------------------------------
" autocmd! BufRead,BufNewFile *.h,*.c set ft=c.doxygen
autocmd! BufRead,BufNewFile *.h,*.c set ft=c

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
" Set up netrw instead of Nerdtree (save a plugin)
"------------------------------------------------------------------------------
" Make it look cleaner like NERDTree
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
" let g:netrw_winsize=25
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
