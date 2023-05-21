#!/bin/bash

if [[ "$#" -ne 1 ]]
then
  echo Exactly 1 argument required
  return 1
fi

if [[ -n $NOTES_EDITOR ]]
then editor=$NOTES_EDITOR
elif [[ -n $EDITOR ]]
then editor=$EDITOR
else editor=vi
fi

$editor "$(notes-dir.sh)/$1"
