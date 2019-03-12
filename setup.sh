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
apt_programs="$(dirname ${BASH_SOURCE[0]})/programs.arch"
$dry_run sudo apt-get update
$dry_run sudo apt-get upgrade -y

echo -e "\nUbuntu: Git prompt and completion"
sudo apt-get install curl
sudo mkdir -p /usr/share/git/completion/
sudo curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /usr/share/git/completion/git-completion.bash
sudo curl -L  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o /usr/share/git/completion/git-prompt.sh
sudo mkdir -p /usr/share/fzf/

echo -e "\nUbuntu: Fzf completion and key-bindings"
sudo curl -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash -o /usr/share/fzf/completion.bash
sudo curl -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash -o /usr/share/fzf/key-bindings.bash
