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
    if ! grep -q "source $dotfiles_bashrc" "${HOME}/.bashrc"; then
        if [[ "$dry_run" ]]; then
            echo "echo source $dotfiles_bashrc >> ${HOME}/.bashrc"
            return
        fi
        echo "source $dotfiles_bashrc" >> "${HOME}/.bashrc"
    fi
}

source_vimrc () {
    # For Neovim
	if [[ "$dry_run" ]]; then
    	if ! grep -q "so $dotfiles_vimrc" "${HOME}/.config/nvim/init.vim"; then
            echo "echo so ${dotfiles_vimrc} >> ${HOME}/.config/nvim/init.vim"
            return
        fi
    fi
    if ! grep -q "so $dotfiles_vimrc" "${HOME}/.config/nvim/init.vim"; then
		mkdir -p ~/.config/nvim/
		echo "so ${dotfiles_vimrc}" >> "${HOME}/.config/nvim/init.vim"
	fi
}

git_bash_completion () {
	if [[ "$dry_run" ]]; then
		echo "sudo curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /etc/bash_completion.d/git-completion.bash"
		return
	fi
	sudo curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
	-o /etc/bash_completion.d/git-completion.bash
}

link_git_config () {
	if [[ "$dry_run" ]]; then
		echo "ln -sf $dotfiles_gitconfig ${HOME}/.gitconfig"
		return
	fi
	ln -sf "$dotfiles_gitconfig" "${HOME}/.gitconfig"
}


echo "Adding sourcing of .bashrc"
source_bashrc
echo "Done!"
echo

echo "Adding sourcing of .vimrc"
source_vimrc
echo "Done!"
echo

echo "Installing BASH completion for Git"
git_bash_completion
echo "Done!"
echo

echo "Linking .gitconfig"
link_git_config
echo "Done!"
