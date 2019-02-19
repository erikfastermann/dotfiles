while git_file="$(git log --follow --diff-filter=A --pretty=format: --name-only . \
    | grep . | fzf)"; [[ "$git_file" ]]; do
    while git_commit="$(git log --follow --pretty=format:'%C(auto)%h %Cblue(%an %ar)%Creset %s' \
        -- $git_file | fzf | cut -c1-7)"; [[ "$git_commit" ]]; do
        git show "${git_commit}:${git_file}" | vim
    done
done
