#!/bin/bash

# Path of the dotfiles folder
dotfiles_dir="${HOME}/dotfiles"


# .bashrc
echo "source ${dotfiles_dir}/.bashrc" >> ~/.bashrc

# .vimrc for neovim
mkdir -p ~/.config/nvim/
echo "so ${dotfiles_dir}/.vimrc" >> ~/.config/nvim/init.vim

