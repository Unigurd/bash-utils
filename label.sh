#!/usr/bin/env bash

function -label-dir() {
  local dir="${LABELS_DIR:-$HOME/.labels}"
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

  cat "$(-label-dir)/$1"
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
