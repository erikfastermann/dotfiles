source /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh
source /usr/share/fzf/completion.bash

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=true

PS1='\[\033[1m\]\u@\h \W$(__git_ps1) [$(echo $?)]\$\[\033[0m\] '

PROMPT_COMMAND="pwd > /tmp/cwd"

export TERM=st
export EDITOR=nvim
export BROWSER=firefox

export DOTFILES=$(dirname ${BASH_SOURCE[0]})
export SCRIPTS="${HOME}/scripts"
export YT_MUSIK="${HOME}/youtube/musik"

export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"

export SAVEHIST=
export HISTFILE=~/.bash_history
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=erasedups
PROMPT_COMMAND="$PROMPT_COMMAND; history -a"
shopt -s histappend
shopt -s cmdhist

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

shopt -s checkwinsize

alias ls="ls --color=auto"
alias grep="grep --color=auto"

alias l="ls -lh"
alias ll="ls -lhA"

CDPATH="$HOME"
alias -- -='cd -'
alias ..='cd ..'

md () { mkdir -p "$1" && cd -P "$1"; }

alias sp="sudo pacman"
alias sv="sudo $EDITOR"

alias gi="git init"
__git_complete gi _git_complete

alias gcl="git clone"
__git_complete gcl _git_clone

alias gst="git status"
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

alias gr="git reset"
__git_complete gr _git_reset

alias gf="git fetch --all"
__git_complete gf _git_fetch

alias gpl="git pull"
__git_complete gpl _git_pull

alias gp="git push"
__git_complete gp _git_push

alias yt="youtube-dl -ciwk -f best --add-metadata -o '%(title)s.%(ext)s' --restrict-filenames"
alias yt-mp3="youtube-dl -ciwx -f best --audio-format mp3 --add-metadata -o '%(title)s.%(ext)s' --restrict-filenames"
alias yt-sync="yt-mp3 --download-archive '${YT_MUSIK}/archive.txt' -o '${YT-MUSIK}/%(playlist)s/%(title)s.%(ext)s' -a '${YT_MUSIK}/youtube.txt'"

alias x='chmod u+x'

if [ "$(tty)" = "/dev/tty1" ]; then
	startx
fi
