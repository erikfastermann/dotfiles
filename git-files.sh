while true; do
    git_file=$(git log --follow --diff-filter=A --pretty=format: --name-only . | grep . | fzf)
    if [[ "$git_file" ]]; then
        while true; do
            git_commit=$(git log --follow --pretty=format:'%C(auto)%h %Cblue(%an %ar)%Creset %s' -- "$git_file" | fzf | cut -c1-7)
            if [[ "$git_commit" ]]; then
                git show "${git_commit}:${git_file}" | vim
            else
                break
            fi
        done
    else
        break
    fi
done
