#!/usr/bin/env bash

function -label-dir() {
  local dir="${LABEL_DIR:-$HOME/.labels}"
	mkdir -p "$dir"
	echo "$dir"
}


function label() {
  if [[ "$#" -ne 1 ]]
	then
	  echo Exactly 1 argument required
	  return 1
	fi

  local regex='^[a-zA-Z0-9_-]+$'
  if [[ "$1" =~ $regex ]]
  then echo $(pwd) > "$(-label-dir)/$1"
  else
    echo "label: Label must match regex '$regex'" 1>&2
    return 1
  fi
}



function label-dest() {
  if [[ -z $1 ]] || [[ -n $2 ]]
  then
    echo Exactly 1 argument required
    return 1
  fi

  local label="$(echo "$1" | perl -ne 'm|(^[^/]*)|; print $1')"
  local rest="$(echo "$1" | perl -ne 'm|/(.*)|; print $1')"
  local label_path="$(-label-dir)/$label"
  if [[ -f "$label_path" ]]
  then
    echo "$(cat "$label_path")/$rest"
  else
    echo "Label '$label' doesn't exist" 1>&2
    return 1
  fi
}


function label-list() {
  ls "$(-label-dir)"
}


function go() {
	if [[ -z $1 ]] || [[ -n $2 ]]
	then
	  echo Exactly 1 argument required
	  return 1
	fi

	cd "$(label-dest $1)"
}

# lals = label ls
function lals() {
	if [[ -z $1 ]] || [[ -n $2 ]]
	then
	  echo Exactly 1 argument required
	  return 1
	fi
  ls -A "$(label-dest $1)"
}
