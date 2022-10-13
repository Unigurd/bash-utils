function note() {
        if [[ -z $1 ]] || [[ -n $2 ]]
        then
                echo Exactly 1 argument required
                return 1
        fi

        vi "$(label-path notes)/$1"
}
