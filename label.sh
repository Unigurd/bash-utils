#!/usr/bin/env bash

function labels-dir() {
	mkdir -p "$HOME/gurd/.labels"
	echo "$HOME/gurd/.labels/"
}

function label() {
  if [[ -z $1 ]] || [[ -n $2 ]]
	then
	  echo Exactly 1 argument required
	  return 1
	fi

	echo $(pwd) > "$(labels-dir)/$1"
}


function label-dest() {
  if [[ -z $1 ]] || [[ -n $2 ]]
  then
    echo Exactly 1 argument required
    return 1
  fi

  cat "$(labels-dir)/$1"
}


function go() {
	if [[ -z $1 ]] || [[ -n $2 ]]
	then
	  echo Exactly 1 argument required
	  return 1
	fi

	cd "$(label-dest $1)"
}
