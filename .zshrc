setopt PROMPT_SUBST

git_status () {
    # Check if Git Directory
    if git rev-parse &> /dev/null; then
	# Check if dirty or untracked files
	if [[ $(git status --porcelain) ]]; then
		git_status_dirty='*'
	fi
        echo "($(git rev-parse --abbrev-ref HEAD 2> /dev/null)$git_status_dirty)"
    fi
}

# Format: user@host ~/some/path (git-branch*) %
PROMPT='%B%n%b@%m %F{green}%~%f $(git_status)%# '

# Auto cd
setopt auto_cd

# Comments in shell
setopt interactivecomments


# Plugins
# Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Non ZSH specific configs in .bashrc
source ~/.bashrc
