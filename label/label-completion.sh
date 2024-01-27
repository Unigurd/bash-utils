function label-completion() {
  if [[ $COMP_CWORD -eq 1 ]]
  then
    local latest="${COMP_WORDS[$COMP_CWORD]}"
    local labels="$(label-list)"
    COMPREPLY=($(compgen -W "$labels" -- $latest))
  fi
  return 0
}

complete -F label-completion go
complete -F label-completion label-dest
complete -F label-completion lls
