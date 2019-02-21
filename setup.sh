#!/bin/bash

# Path of the dotfiles folder
dotfiles_dir="${HOME}/dotfiles"


# .bashrc
echo "source ${dotfiles_dir}/.bashrc" >> ~/.bashrc

# Install Git BASH completion
sudo curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
-o /etc/bash_completion.d/git-completion.bash

# .vimrc for neovim
mkdir -p ~/.config/nvim/
echo "so ${dotfiles_dir}/.vimrc" >> ~/.config/nvim/init.vim

# Gitconfig
ln -sf "${dotfiles_dir}/.gitconfig" "${HOME}/.gitconfig"
