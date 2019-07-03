call plug#begin('~/.local/share/nvim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

set nocompatible
set number relativenumber
set mouse=a
syntax on

" Tab as 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

