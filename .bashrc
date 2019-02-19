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
# Bash completion
source /etc/bash_completion.d/git-completion.bash

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

# Execute commands on all non bare repositories from a folder
# USAGE: git-all dir args...
gall () {
    local exec_command="${@:2}"
    find "$1" -name .git -type d -execdir bash -c "$exec_command" \;
}

# Execute commands on all non bare repositories with differences from upstream from a folder
# USAGE: git-upstream dir args...
gupstream () {
    local exec_command="${@:2}"
    gall "$1" "if [[ \"\$(git rev-list --left-right @...@{upstream} 2> /dev/null)\" ]]; then $exec_command; fi"
}

# Browse commits for a specific file, view commit in $EDITOR
gbrowse () {
    local git_folder="$1"
    while local git_file="$(git -C $git_folder log --follow --diff-filter=A --pretty=format: --name-only . \
        | grep . | fzf)"; [[ "$git_file" ]]; do
        while local git_commit="$(git -C $git_folder log --follow --pretty=format:'%C(auto)%h %Cblue(%an %ar)%Creset %s' \
            -- $git_file | fzf | cut -c1-7)"; [[ "$git_commit" ]]; do
            git -C "$git_folder" show "${git_commit}:${git_file}" | "$EDITOR"
        done
    done
}

# Save current work to branch and push
gwip () {
    local wip_branch="WIP-$(git branch | grep \* | cut -d ' ' -f2)" && \
    git checkout -b "$wip_branch" && \
    git add -A && git commit -m "$(date '+%F %T')" && \
    git push origin "$wip_branch"
}

# Cherry-pick -n latest commit from pulled WIP-branch
# and delete this branch local and remote
gresume () {
    local current_branch="$(git branch | grep \* | cut -d ' ' -f2)" && \
    git pull && \
    git checkout "WIP-$current_branch"
    local last_commit=$(git log "WIP-$current_branch" -n1 --pretty=format:"%H" --) && \
    git checkout "$current_branch" && \
    git cherry-pick -n "$last_commit" && \
    git branch -D "WIP-$current_branch" && \
    git push --delete origin "WIP-$current_branch"
}


# Select a line from a file in a chosen folder with fzf,
# then an editor opens at the specified line
s () {
    local selected_line=$(find ${1}/* -type f | xargs grep -n -H . | sed "s+${1}++" | fzf)
    if [[ "$selected_line" ]]; then
        local selected_path=$(echo "${1}${selected_line}" | cut -d ':' -f1)
        local selected_line_number=$(echo "$selected_line" | cut -d ':' -f2)
        "$EDITOR" "$selected_path" +"${selected_line_number}" -c 'normal z.'
    fi
}

USEFUL_COMMANDS_PATH="${HOME}/useful-commands"
alias uc='s "$USEFUL_COMMANDS_PATH"'
