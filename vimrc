" Make tabs as wide as 4 spaces and expand it automately
set tabstop=4 shiftwidth=4 expandtab

" auto indent
set autoindent

" Let tabs display as characters
set list
set listchars=tab:>-
" Let trailing spaces display as x
set listchars=trail:x

" Search related

" hight light search
set hlsearch
set incsearch

" Enable file type check
filetype on

" Enable syntax highlight
syntax on

" Enable the number syntax before lines
set number

" Use zsh like autocomplet menu
set wildmenu
set wildmode=full

" Automatically switch to case-sensitive search if use any capital letters
set smartcase

" Set the color scheme
colorscheme molokai
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1

" Back to current folder using :E
set autochdir
