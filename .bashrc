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

# Commenly used files
alias .b="$EDITOR ${DOTFILES_PATH}/.bashrc"
alias .v="$EDITOR ${DOTFILES_PATH}/.vimrc"
alias .p="$EDITOR ${DOTFILES_PATH}/programs.apt"

alias gst="git status --show-stash --untracked"
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

# Auto-commit
alias gauto="bash ${DOTFILES_PATH}/auto-commit.sh"

# Execute commands on all non bare repositories from a folder
# USAGE: gall dir args...
gall () {
    local find_dir="$1"
    if [[ "$find_dir" == "" ]]; then
        find_dir="$HOME"
    fi
    local exec_command="${@:2}"
    if [[ "$exec_command" == "" ]]; then
        exec_command="pwd"
    fi
    find "$find_dir" -name .git -type d -execdir bash -c "$exec_command" \;
}

# Execute commands on all non bare repositories with differences from upstream from a folder
# USAGE: gup dir args...
gup () {
    local find_dir="$1"
    if [[ "$find_dir" == "" ]]; then
        find_dir="$HOME"
    fi
    local exec_command="${@:2}"
    if [[ "$exec_command" == "" ]]; then
        exec_command="pwd"
    fi
    gall "$find_dir" "if [[ \"\$(git rev-list --left-right @...@{upstream} 2> /dev/null)\" ]]; then $exec_command; fi"
}

# Show status for all dirty repos in the HOME folder
alias gsta='gall "$HOME" "if [[ \$(git status --porcelain) ]]; then pwd && git status --short --branch && echo; fi;"'

# Fetch all repos in the HOME folder and show repos with differences from upstream
alias gfa='gall "$HOME" echo \&\& pwd \&\& git fetch --all; echo -----------;gup "$HOME" echo \&\& pwd \&\& git status --short --branch'

# Browse commits for a specific file, view commit in $EDITOR
# USAGE: gbrowse dir
gbrowse () {
    local git_folder="$1"
    if [[ "$git_folder" == "" ]]; then
        git_folder="."
    fi
    while local git_file="$(git -C $git_folder log --follow --diff-filter=A --pretty=format: --name-only . \
        | grep . | fzf)"; [[ "$git_file" ]]; do
        while local git_commit="$(git -C $git_folder log --follow --pretty=format:'%C(auto)%h %Cblue(%an %ar)%Creset %s' \
            -- $git_file | fzf | cut -c1-7)"; [[ "$git_commit" ]]; do
            git -C "$git_folder" show "${git_commit}:${git_file}" | "$EDITOR" "$git_file"
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
sl () {
    local search_dir="$1"
    if [[ "$search_dir" == "" ]]; then
        search_dir="."
    fi
    local selected_line=$(find "$search_dir" -type f -not -path "*.git/*" | xargs grep -n -H . | sed "s+${search_dir}++" | fzf)
    if [[ "$selected_line" ]]; then
        local selected_path=$(echo "${search_dir}${selected_line}" | cut -d ':' -f1)
        local selected_line_number=$(echo "$selected_line" | cut -d ':' -f2)
        "$EDITOR" "$selected_path" +"${selected_line_number}" -c 'normal z.'
    fi
}

# Search-line for useful-commands
alias uc='sl "$USEFUL_COMMANDS_PATH"'


# Notes
source ~/dotfiles/notes-completion.bash
alias n=
