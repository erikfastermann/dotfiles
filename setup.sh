#!/bin/bash

# Configure the path of the repository
dotfiles_dir="${HOME}/dotfiles"

# .bashrc
echo "source ${dotfiles_dir}/.bashrc" >> ~/.bashrc

# .zshrc
echo "source ${dotfiles_dir}/.zshrc" >> ~/.zshrc

# .vimrc for neovim
mkdir -p ~/.config/nvim/
echo "so ${dotfiles_dir}/.vimrc" >> ~/.config/nvim/init.vim
