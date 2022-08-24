" Map keys
" Use arrow keys to move between panes
map <up> <C-w><up>
map <down> <C-w><down>
map <left> <C-w><left>
map <right> <C-w><right>

" Make tabs as wide as 4 spaces and expand it automately
set tabstop=4 shiftwidth=4 expandtab

" auto indent
set nocindent
set autoindent
set formatoptions=

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

" enable backspace to delete indent, eol, start
set backspace=indent,eol,start

" Set the color scheme
colorscheme molokai
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1

" define a reverse key to C-i, see more detail at: https://stackoverflow.com/questions/67042601
function! BAT()
        while getline(".")[col(".")-2] =~ "\\s"
                normal X
                if virtcol(".")%&tabstop == 1
                        break
                endif
        endwhile
endfunction
imap <S-Tab> <C-O>:call BAT()<CR>

" Back to current folder using :E
" set autochdir

" Install vim-plug first https://github.com/junegunn/vim-plug
" :PlugInstall to install Plugins1
call plug#begin()

" smooth scroll
Plug 'psliwka/vim-smoothie'

" NERDTree
Plug 'preservim/nerdtree'

" tagbar
Plug 'preservim/tagbar'

" LSP Client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" fuzzy find (both two is needed)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" AgIn: Start ag in the specified directory
"
" e.g.
"   :AgIn .. foo
function! s:ag_in(bang, ...)
  let start_dir=expand(a:1)

  if !isdirectory(start_dir)
    throw 'not a valid directory: ' .. start_dir
  endif
  " Press `?' to enable preview window.
  call fzf#vim#ag(join(a:000[1:], ' '), fzf#vim#with_preview({'dir': start_dir}, 'up:50%:hidden', '?'), a:bang)

endfunction

command! -bang -nargs=+ -complete=dir AgIn call s:ag_in(<bang>0, <f-args>)

" rainbow bracket
" Plug 'frazrepo/vim-rainbow'
Plug 'luochen1990/rainbow'

" full test search
Plug 'mileszs/ack.vim'

" Git Blame
Plug 'tpope/vim-fugitive'

call plug#end()

