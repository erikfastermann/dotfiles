#!/bin/bash

# A script to install and setup the system my way
# WARNING: This will overwrite some of your existing configs
# Use -n (--dry) to see what would happen

# CONFIG
dotfiles_dir="${HOME}/dotfiles"

set -e


dry_run=
if [[ "$1" == "--dry" ]] || [[ "$1" == "-n" ]]; then
    dry_run="echo"
fi

echo -e "\nCloning/pulling personal repos"
git_repos=("https://github.com/erikfastermann/dotfiles" \
    "https://github.com/erikfastermann/scripts" \
    "https://github.com/erikfastermann/useful-commands")
for repo in "${git_repos[@]}"; do
    clone_path="${HOME}/${repo##*/}"
    $dry_run git -C "$clone_path" pull \
        || git clone "$repo" "$clone_path"
done

echo -e "\nAdding sourcing of .bashrc"
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

echo -e "\nLinking .gitconfig"
dotfiles_gitconfig="${dotfiles_dir}/.gitconfig"
git_config="${HOME}/.gitconfig"
$dry_run ln -sf "$dotfiles_gitconfig" "$git_config"

echo -e "\nUpdating, upgrading and installing packages"
progs="$(dirname ${BASH_SOURCE[0]})/programs.arch"
$dry_run sudo pacman -Syy
$dry_run sudo pacman --noconfirm -Su
$dry_run xargs -a "$progs" sudo pacman --needed --noconfirm -S 
