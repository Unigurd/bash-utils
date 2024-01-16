function label-completion() {
  if [[ $COMP_CWORD -eq 1 ]]
  then
    latest="${COMP_WORDS[$COMP_CWORD]}"
    labels="$(label-list)"
    COMPREPLY=($(compgen -W "$labels" -- $latest))
  fi
  return 0
}

complete -F label-completion go
