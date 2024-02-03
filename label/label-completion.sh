label-completion() {
  local nullglob=$(shopt -p nullglob)
  shopt -s nullglob
  echo COMP_CWORD: "$COMP_CWORD"
  echo COMP_WORDS: "${COMP_WORDS[@]}"
  local arg
  local actual_completion=""
  # if [[ 1 -eq "$#" ]]
  # then
  #   arg=$1

  if [[ 1 -eq "$COMP_CWORD" ]]
  then
    arg=${COMP_WORDS[$COMP_CWORD]}
    actual_completion=true
  else # Only complete if there is exactly one argument
    return 0
  fi
  # elif [[ 1 -eq "$#" ]]
  # if [[ 0 -eq "$#" ]]
  # then
  #   if [[ 1 -eq "$COMP_CWORD" ]]
  #   then
  #     arg=${COMP_WORDS[$COMP_CWORD]}
  #     actual_completion=true
  #   else # Only complete if there is exactly one argument
  #     return 0
  #   fi
  # elif [[ 1 -eq "$#" ]]
  # then
  #   arg=$1
  # elif [[ 2 -eq "$#" ]]
  # then
  #   if [[ -n "$1" ]]
  #   then
  #     arg=$2
  #     actual_completion=true
  #   else
  #     return 0
  #   fi
  # else
  #   echo At most two arguments! 1>&2
  #   return 2
  # fi

  # local arg=${COMP_WORDS[$COMP_CWORD]}
  local COMPREPLY=""
  local arg=$1
  local label=${arg%%/*} # label will be empty if there is no slash in arg

  if [[ -z "$label" ]]
  then  # If there is no slash in arg, just suggest labels to autocomplete on
    local labels=$(label-list)
    COMPREPLY=($(compgen -W "$labels" -- $arg))

  else # label-dest needs to return non-0 on failure
    if label-dest "$label" >/dev/null 2>&1
    then  # The label part is an actual label
      local rest_path=${arg#*/}
      local label_dest=$(label-dest "$label")
      local path=${label_dest%/}/$rest_path

      local normal_files=("$path"*)
      case $rest_path in
        */) local hidden_files=("$path".*);;
        *)  local hidden_files=();;
      esac

      local _files1=("${normal_files[@]}" "${hidden_files[@]}")
      # Add trailing / to folders
      local _files2=()
      for file in "${_files1[@]}"
      do
        if [[ -d "$file" ]]
        then _files2+=("${file%/}/")
        else _files2+=("$file")
        fi
      done

      # Remove the label_path part of each file's path
      local files=("${_files2[@]#$label_dest}")
      # And add the label to the front
      local matches=${files[@]/#/$label/}

      if [[ -n "$actual_completion" ]]
      then
        COMPREPLY=($(compgen -W "${matches[*]}" -- "$arg"))
      else
        echo "${matches[@]}"
      fi
    fi
  fi
  $nullglob
}

complete -F label-completion go
complete -F label-completion label-dest
complete -F label-completion lals
