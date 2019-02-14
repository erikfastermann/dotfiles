# Prompt
source /etc/bash_completion.d/git-prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=true
PS1='\[\033[1;37m\]\u\[\033[0m\]@\h \[\033[0;32m\]\w\[\033[0m\] $(__git_ps1 "(%s)")\$ '


# Initial Setup
export EDITOR=vim

# History
SAVEHIST=1000
HISTFILE=~/.bash_history


# Aliases
# File Ops
alias ls="ls --color"
alias l="ls -l"
alias la="ls -lA"
alias -- -="cd -"
md () { mkdir -p "$1" && cd -P "$1"; };

# Git
alias gst="git status --show-stash"
alias gl="git log --oneline --decorate --graph"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -v"
alias gac="git add -A && git commit -v"
alias gacp="git add -A && git commit -v && git push"
alias gb="git branch"
alias gco="git checkout"
alias gm="git merge --no-ff"
