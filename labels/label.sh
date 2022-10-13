#!/usr/bin/env bash

function label() {
	if [[ -z $1 ]] || [[ -n $2 ]]
	then
	        echo Exactly 1 argument required
	        return 1
	fi

	echo $(pwd) > "$(labels-dir)/$1"
}

