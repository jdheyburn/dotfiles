

call plug#begin('~/.vim/bundle')
Plug 'itchyny/lightline.vim'
Plug 'https://tpope.io/vim/commentary.git'
call plug#end()

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
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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

if empty(glob('~/.vim/.undodir'))
    silent !mkdir -p ~/.vim/.undodir
endif
set undodir=~/.vim/.undodir//

set undofile
set updatetime=100
set viminfo='10,\"100,:20,%,n~/.vim/.viminfo

set number
highlight LineNr ctermfg=grey

