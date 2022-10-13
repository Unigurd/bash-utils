#!/usr/bin/env bash

function label-path() {
        if [[ -z $1 ]] || [[ -n $2 ]]
        then
                echo Exactly 1 argument required
                return 1
        fi

        cat "$(labels-dir)/$1"
}
