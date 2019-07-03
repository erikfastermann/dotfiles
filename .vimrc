call plug#begin('~/.local/share/nvim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

so ~/.config/nvim/vim-commentary/plugin/commentary.vim
so ~/.config/nvim/vim-surround/plugin/surround.vim

set nocompatible
set number relativenumber
set mouse=a
syntax on

" Tab as 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

