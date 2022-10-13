#!/usr/bin/env bash

function goto() {
	if [[ -z $1 ]] || [[ -n $2 ]]
	then
	        echo Exactly 1 argument required
	        return 1
	fi

	cd "$(label-path $1)"
}
