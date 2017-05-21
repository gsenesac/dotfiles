
colorscheme torte

"Sometimes I've still got my finger on shift
inoremap jk <Esc>
inoremap jK <Esc>
inoremap Jk <Esc>
inoremap JK <Esc>

set number
syntax on
set cursorline

set tabstop=4
set shiftwidth=4
set expandtab

set scrolloff=3

set backspace=indent,eol,start

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

set noerrorbells
set noruler
set laststatus=2
set statusline=%.40f
set statusline+=%=
set statusline+=%l
set statusline+=/
set statusline+=%L

set tags=./tags;
