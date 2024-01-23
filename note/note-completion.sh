function note-completion() {
  if [[ $COMP_CWORD -eq 1 ]]
  then
    local latest="${COMP_WORDS[$COMP_CWORD]}"
    local notes="$(note-list)"
    COMPREPLY=($(compgen -W "$notes" -- $latest))
  fi
  return 0
}

complete -F note-completion note
