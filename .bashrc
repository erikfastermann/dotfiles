# Bash-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# Prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=true
PS1='\[\033[1;37m\]\u\[\033[0m\]@\h \[\033[0;32m\]\w\[\033[0m\] $(__git_ps1 "(%s)")\$ '

# Initial Setup
export EDITOR=vim

export DOTFILES_PATH=$(dirname ${BASH_SOURCE[0]})
export SCRIPTS_PATH="${HOME}/scripts"
export USEFUL_COMMANDS_PATH="${HOME}/useful-commands"
export NOTES_PATH="$HOME/notes"

# History
SAVEHIST=1000
HISTFILE=~/.bash_history


# Color
alias ls="ls --color=auto"
alias grep="grep --color=auto"


# File Ops
alias l="ls -l"
alias ll="ls -lA"

shopt -s autocd
alias -- -="cd -"

md () { mkdir -p "$1" && cd -P "$1"; }

# Commenly used dirs
alias dot="cd $DOTFILES_PATH"
alias ncd="cd $NOTES_PATH"
alias s="cd $SCRIPTS_PATH"

# Commenly used files
alias .b="$EDITOR ${DOTFILES_PATH}/.bashrc"
alias .v="$EDITOR ${DOTFILES_PATH}/.vimrc"
alias .p="$EDITOR ${DOTFILES_PATH}/programs.apt"


# Apt
alias sai="sudo apt-get update && sudo apt-get install"
alias sau="sudo apt-get update && sudo apt-get upgrade -y"


# Git
alias gst="git status --show-stash"
__git_complete gst _git_status

alias gl="git log --oneline --graph --all"
alias gll="git log --graph --all --pretty=format:'%C(auto)%h%d %Cblue(%an %ar)%Creset %s'"

alias gd="git diff"
__git_complete gd _git_diff

alias ga="git add"
__git_complete ga _git_add

alias gc="git commit -v"
__git_complete gc _git_commit

alias gac="git add -A && git commit -v"
alias gacp="git add -A && git commit -v && git push"

alias gb="git branch"
__git_complete gb _git_branch

alias gco="git checkout"
__git_complete gco _git_checkout

alias gm="git merge"
__git_complete gm _git_merge

alias gr="git reset"
__git_complete gr _git_reset

alias gf="git fetch --all"
__git_complete gf _git_fetch

alias gpl="git pull"
__git_complete gpl _git_pull

alias gp="git push"
__git_complete gp _git_push

# Reset initial commit and unstage all
alias gr-initial="git update-ref -d HEAD && git reset"

# Auto-commit
alias gauto="bash ${SCRIPTS_PATH}/git/auto-commit.sh"

# Auto-commit separate
# alias gauto-seperate="bash ${SCRIPTS_PATH}/git/auto-commit-separate.sh"

# Show status for all dirty repos in the HOME folder
# alias gsta='gall "$HOME" "if [[ \$(git status --porcelain) ]]; then pwd && git status --short --branch && echo; fi;"'

# Fetch all repos in the HOME folder and show repos with differences from upstream
# alias gfa='gall "$HOME" echo \&\& pwd \&\& git fetch --all; echo -----------;gup "$HOME" echo \&\& pwd \&\& git status --short --branch'


# Search-line for useful-commands
# alias uc='sl "$USEFUL_COMMANDS_PATH"'


# Notes
source ~/dotfiles/notes-completion.bash
alias n=
