# Bash-completion
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh


# Prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=true
PS1='\[\033[1;31m\]\u@\h \[\033[1;32m\]\w\[\033[0m\]\[\033[1;36m\]$(__git_ps1)\[\033[0m\]\$ '

# Initial Setup
export EDITOR=vim
export BROWSER=firefox

export DOTFILES=$(dirname ${BASH_SOURCE[0]})
export SCRIPTS="${HOME}/scripts"
export USEFUL_COMMANDS="${HOME}/useful-commands"
export NOTES="$HOME/notes"

# History
SAVEHIST=1000
HISTFILE=~/.bash_history


# Color
alias ls="ls --color=auto"
alias grep="grep --color=auto"


# Setup
alias setup="bash ${DOTFILES}/setup.sh"


# File Ops
alias l="ls -l"
alias ll="ls -lA"

shopt -s autocd
alias -- -="cd -"

md () { mkdir -p "$1" && cd -P "$1"; }

# Commenly used dirs
alias dot="cd $DOTFILES"
alias ncd="cd $NOTES"
alias s="cd $SCRIPTS"
alias u="cd $USEFUL_COMMANDS"

# Commenly used files
alias .b="$EDITOR ${DOTFILES}/.bashrc"
alias .v="$EDITOR ${DOTFILES}/.vimrc"
alias .g="$EDITOR ${DOTFILES}/.gitconfig"
alias .p="$EDITOR ${DOTFILES}/programs.apt"


# Pacman
alias sp="sudo pacman"


# Git
alias gi="git init"
__git_complete gi _git_complete

alias gcl="git clone"
__git_complete gcl _git_clone

alias gst="git status --show-stash"
__git_complete gst _git_status

alias gl="git log --graph --all --format='%C(auto)%h%d %s %Cblue(%ar) %Cgreen<%an>%Creset'"
__git_complete gl _git_log

alias gll="gl --stat"
__git_complete gll _git_log

alias gd="git diff"
__git_complete gd _git_diff

alias ga="git add"
__git_complete ga _git_add

alias gc="git commit -v"
__git_complete gc _git_commit

alias gac="git add -A && git commit -v"
alias gacp="git add -A && git commit -v && git push"

alias gb="git branch -vv"
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

# Exec a command on all repos in some dir
alias gall="bash ${SCRIPTS}/git/exec-on-all-repos.sh"

# Exec a command on all repos with differences in upstream in some dir
alias gup="bash ${SCRIPTS}/git/exec-on-upstream-repos.sh"

# Show status for all dirty repos in the HOME folder
gsta () {
    local dir=$([ -z "$1" ] && echo "$HOME" || echo "$1")
    gall "$dir" "if [[ \$(git status --porcelain) ]]; then pwd && git status --short --branch && echo; fi;"
}

# Fetch all repos in the HOME folder and show repos with differences from upstream
gfa () {
    local dir=$([ -z "$1" ] && echo "$HOME" || echo "$1")
    gall "$dir" echo \&\& pwd \&\& git fetch --all
    echo -----------
    gup "$dir" echo \&\& pwd \&\& git status --short --branch
}


# Search thru all lines in files of some dir
alias sl="bash ${SCRIPTS}/search/search-lines.sh"

# Search-line for useful-commands
alias uc='sl "$USEFUL_COMMANDS"'


# Notes
source ~/dotfiles/notes-completion.bash
alias n=
