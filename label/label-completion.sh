label-completion() {
  if [[ 1 -eq "$COMP_CWORD" ]]
  then # Ensure there is only one argument to the command
    label-completion_ files "${COMP_WORDS[$COMP_CWORD]}"
  fi
}

go-completion() {
  if [[ 1 -eq "$COMP_CWORD" ]]
  then # Ensure there is only one argument to the command
    label-completion_ '' "${COMP_WORDS[$COMP_CWORD]}"
  fi
}

label-completion_() {
  # Enable nullglob
  local nullglob=$(shopt -p nullglob)
  shopt -s nullglob

  if [[ 2 -eq "$#" ]]
  then # Ensure there is only one argument to the command
    local option=$1
    local arg=$2
    local label=${arg%%/*}

    if [[ "$arg" != *"/"* ]]
    then  # If there is no slash in arg just suggest labels to autocomplete on
      local labels0=()
      for other_label in $(label-list)
      do [[ "$other_label" == "$arg"* ]] && labels0+=("$other_label")
      done

      if label-dest "$label" >/dev/null 2>&1
      then # arg is a complete label
        # Add a trailing slash to arg to indicate you can complete further,
        # but don't add a slash to the other completion suggestions
        local labels1=()
        for other_label in "${labels0[@]}"
        do
          if [[ "$label" == "$other_label" ]]
          then labels1+=("$label/")
          else labels1+=("$other_label")
          fi
        done


      else # arg is not a complete label so we just suggest labels straight
        labels1=("${labels0[@]}")
      fi
      COMPREPLY=("${labels1[@]}")

    else # There is a slash in arg so we look for paths to complete on
      # label-dest needs to return non-0 on failure
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
          else [[ "$option" == files ]] &&_files2+=("$file")
          fi
        done

        # Remove the label_path part of each file's path
        local files=("${_files2[@]#$label_dest}")
        # And add the label to the front
        local matches=("${files[@]/#/$label/}")

        COMPREPLY=("${matches[@]}")
      fi
    fi
  fi

  # Disable nullglob
  $nullglob
}

complete -o nospace -F go-completion go
complete -o nospace -F label-completion label-dest
complete -o nospace -F label-completion lals
