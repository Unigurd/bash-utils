#!/bin/bash

if [[ "$#" -ne 0 ]]
then
  echo No arguments!
  return 1
fi

if [[ -n "$NOTES_DIR" ]]
  then
  mkdir -p "$NOTES_DIR"
  echo "$NOTES_DIR"
else
  mkdir -p ~/.notes
  echo ~/.notes
fi
