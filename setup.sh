#!/bin/bash

# A script to install and setup the system my way
# WARNING: This will overwrite some of your existing configs
# Use --dry to see what would happen

# CONFIG
dotfiles_dir="${HOME}/dotfiles"

set -e


dry_run=
if [[ "$1" == "--dry" ]]; then
    dry_run="echo"
fi

echo "Adding sourcing of .bashrc"
dotfiles_bashrc="${dotfiles_dir}/.bashrc"
bash_config="${HOME}/.bashrc"
if ! [[ "$dry_run" ]]; then
    echo "source $dotfiles_bashrc" > "$bash_config"
else
    echo "echo source $dotfiles_bashrc > $bash_config"
fi

echo -e "\nAdding sourcing of .vimrc"
dotfiles_vimrc="${dotfiles_dir}/.vimrc"
neovim_config_dir="${HOME}/.config/nvim"
$dry_run mkdir -p "$neovim_config_dir"
neovim_config="${neovim_config_dir}/init.vim"
if ! [[ "$dry_run" ]]; then
    echo "so $dotfiles_vimrc" > "$neovim_config"
else
    echo "echo so $dotfiles_vimrc > $neovim_config"
fi

echo -e "\nInstalling BASH completion for Git"
git_completion_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
completion_output="/etc/bash_completion.d/git-completion.bash"
$dry_run sudo curl -L "$git_completion_url" -o "$completion_output"

echo -e "\nLinking .gitconfig"
dotfiles_gitconfig="${dotfiles_dir}/.gitconfig"
git_config="${HOME}/.gitconfig"
$dry_run ln -sf "$dotfiles_gitconfig" "$git_config"
