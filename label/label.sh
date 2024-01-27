#!/usr/bin/env bash

function -label-dir() {
  local dir="${LABEL_DIR:-$HOME/.labels}"
	mkdir -p "$dir"
	echo "$dir"
}


function label() {
  if [[ -z $1 ]] || [[ -n $2 ]]
	then
	  echo Exactly 1 argument required
	  return 1
	fi

	echo $(pwd) > "$(-label-dir)/$1"
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
