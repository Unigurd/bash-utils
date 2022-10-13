#!/bin/bash

function ensure_directory() {
	local path=$(realpath -m "$1")
        if ! [[ -e "$path" ]]
        then mkdir -p "$path"
        else
                if ! [[ -d "$path" ]]
                then
                        rm "$path"
                        mkdir "$path"
                fi
        fi

}

ensure_directory $1
