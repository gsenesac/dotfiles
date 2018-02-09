if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" Initialize plugin system
call plug#end()

let g:ackprg = 'ag --vimgrep'

colorscheme torte

"Sometimes I've still got my finger on shift
inoremap jk <Esc>
inoremap jK <Esc>
inoremap Jk <Esc>
inoremap JK <Esc>

set number
set relativenumber

syntax on
set cursorline

set complete+=kspell

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
