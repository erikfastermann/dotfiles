_notes_comp () {
    local IFS=$'\n'
    local cur_dir="$(pwd)"
    local cur="${COMP_WORDS[COMP_CWORD]}"
    if [[ "$cur_dir" == "$NOTES_PATH"* ]]; then
        COMPREPLY=($(compgen -W "$(find $cur_dir -type d -printf '%P/\n' && find $cur_dir -type f -printf '%P\n')" -- "$cur"))
    else
        COMPREPLY=($(compgen -W "$(find $NOTES_PATH -type d -printf '%p/\n' && find $NOTES_PATH -type f)" -- "$cur"))
    fi
}

complete -F _notes_comp n
