call plug#begin('~/.local/share/nvim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

so ~/.config/nvim/vim-commentary/plugin/commentary.vim
so ~/.config/nvim/vim-surround/plugin/surround.vim

set nocompatible
set number relativenumber
set mouse=a
syntax on
set autoread
set scrolloff=3
set ignorecase
set smartcase

set statusline=%t\ %m\ %r\ %=\ %{&ff}\ %{&fileencoding}\ %y\ %l\,%c\ %L

hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

let g:go_fmt_command = "goimports"

set path+=~/go/src
set path+=/usr/lib/go/src
