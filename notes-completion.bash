_notes_comp () {
    current_dir="$(pwd)"
    if [[ "$current_dir" == "$HOME/notes"* ]]; then
        COMPREPLY=($(compgen -W "$(find $current_dir -printf '%P\n')" "${COMP_WORDS[COMP_CWORD]}"))
    else
        COMPREPLY=($(compgen -W "$(find /home/erik/notes/. -printf '%P\n')" "${COMP_WORDS[COMP_CWORD]}"))
    fi
}

complete -F _notes_comp n
