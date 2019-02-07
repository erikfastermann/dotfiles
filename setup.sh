#!/bin/bash

# NOTE: If ZSH doesn't work properly (bash-completion errors),
# you maybe have to reconfigure your existing bashrc.

# Path of the dotfiles folder
dotfiles_dir="${HOME}/dotfiles"


# .bashrc
echo "source ${dotfiles_dir}/.bashrc" >> ~/.bashrc

# .zshrc
echo "source ${dotfiles_dir}/.zshrc" >> ~/.zshrc

# .vimrc for neovim
mkdir -p ~/.config/nvim/
echo "so ${dotfiles_dir}/.vimrc" >> ~/.config/nvim/init.vim


# ZSH Autosuggestions
mkdir -p ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions

# ZSH Syntax highlighting
mkdir -p ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

