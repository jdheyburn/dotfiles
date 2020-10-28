" TODO comment each option and say what they're doing

" Plugins now governed by nix
" call plug#begin('~/.vim/bundle')
" Plug 'itchyny/lightline.vim'
" Plug 'https://tpope.io/vim/commentary.git'
" call plug#end()

" -------------------------
" Lightline.vim
" -------------------------
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night',
      \ }

" -------------------------
" Various Vim options
" -------------------------

" Remember last position
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" Fix tabs when pasting in
set paste
set tabstop=4
set expandtab

set backupcopy=yes

if empty(glob('~/.vim/.backup'))
    silent !mkdir -p ~/.vim/.backup
endif
set backupdir=~/.vim/.backup//

if empty(glob('~/.vim/.swp'))
    silent !mkdir -p ~/.vim/.swp
endif
set directory=~/.vim/.swp//

set hidden
set lazyredraw
set nocompatible
set backspace=2
set nojoinspaces
set ofu=syntaxcomplete#Complete
" set sessionoptions-=curdir " Increase session compatbility with vim-rooter
set scrolloff=10
set showtabline=2
set splitright
set switchbuf=useopen,usetab

" Record undo history 
if empty(glob('~/.vim/.undodir'))
    silent !mkdir -p ~/.vim/.undodir
endif
set undodir=~/.vim/.undodir//
set undofile

" Length of time in ms Vim waits after you stop typing before swap file is written to disk
set updatetime=750

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.vim/.viminfo

set number
highlight LineNr ctermfg=grey