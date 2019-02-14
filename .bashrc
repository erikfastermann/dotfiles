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


# File Ops
alias ls="ls --color"
alias l="ls -l"
alias ll="ls -lA"

shopt -s autocd
alias -- -="cd -"

md () { mkdir -p "$1" && cd -P "$1"; };


# Git
alias gst="git status --show-stash"
alias gl="git log --oneline --graph --all"
alias gll="git log --graph --pretty=format:'%C(auto)%h%d %Cblue(%an %ar)%Creset %s'"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -v"
alias gac="git add -A && git commit -v"
alias gacp="git add -A && git commit -v && git push"
alias gb="git branch"
alias gco="git checkout"
alias gm="git merge"

# Save current work to branch and push
gwip () {
    wip_branch="WIP-$(git branch | grep \* | cut -d ' ' -f2)" && \
    git checkout -b "$wip_branch" && \
    git add -A && git commit -m "$(date '+%F %T')" && \
    git push origin "$wip_branch"
}

# Cherry-pick -n latest commit from pulled WIP-branch
# and delete this branch local and remote
gresume () {
    current_branch="$(git branch | grep \* | cut -d ' ' -f2)" && \
    git pull && \
    git checkout "WIP-$current_branch"
    last_commit=$(git log "WIP-$current_branch" -n1 --pretty=format:"%H" --) && \
    git checkout "$current_branch" && \
    git cherry-pick -n "$last_commit" && \
    git branch -D "WIP-$current_branch" && \
    git push --delete origin "WIP-$current_branch"
}


