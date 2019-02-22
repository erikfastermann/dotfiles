#!/bin/bash

# A script to install and setup the system my way
# Use --dry to see what would happen

# CONFIG:
dotfiles_dir="${HOME}/dotfiles"
dotfiles_bashrc="${dotfiles_dir}/.bashrc"
dotfiles_vimrc="${dotfiles_dir}/.vimrc"
dotfiles_gitconfig="${dotfiles_dir}/.gitconfig"

set -e


dry_run=
if [[ "$1" == "--dry" ]]; then
    dry_run="echo"
fi


source_bashrc () {
    local bash_config="${HOME}/.bashrc"
    if ! grep -q "source $dotfiles_bashrc" "$bash_config"; then
        echo "echo source $dotfiles_bashrc >> $bash_config"
        if ! [[ "$dry_run" ]]; then
            echo "source $dotfiles_bashrc" >> "$bash_config"
        fi
    fi
}

source_vimrc () {
    # For Neovim
    local neovim_config_dir="${HOME}/.config/nvim"
	if ! [ -f "$neovim_config_dir" ]; then
        echo "mkdir -p $neovim_config_dir"
        if ! [[ "$dry_run" ]]; then
		    mkdir -p "$neovim_config_dir"
        fi
    fi
    
    local neovim_config="${neovim_config_dir}/init.vim"
    if ! grep -q "so $dotfiles_vimrc" "$neovim_config"; then
        echo "echo so $dotfiles_vimrc >> $neovim_config"
        if ! [[ "$dry_run" ]]; then
		    echo "so $dotfiles_vimrc" >> "$neovim_config"
        fi
	fi
}

git_bash_completion () {
    local git_completion_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
    local completion_output="/etc/bash_completion.d/git-completion.bash"
	echo "sudo curl -L $git_completion_url -o $completion_output"
	if ! [[ "$dry_run" ]]; then
	    sudo curl -L "$git_completion_url" -o "$completion_output"
	fi
}

link_git_config () {
    git_config="${HOME}/.gitconfig"
	echo "ln -sf $dotfiles_gitconfig $git_config"
	if ! [[ "$dry_run" ]]; then
	    ln -sf "$dotfiles_gitconfig" "$git_config"
	fi
}


echo "Adding sourcing of .bashrc"
source_bashrc
echo "Done!"
echo ----------------

echo "Adding sourcing of .vimrc"
source_vimrc
echo "Done!"
echo ----------------

echo "Installing BASH completion for Git"
git_bash_completion
echo "Done!"
echo ----------------

echo "Linking .gitconfig"
link_git_config
echo "Done!"
