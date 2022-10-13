#!/usr/bin/env bash

function labels-dir() {
	ensure_directory.sh "$HOME/gurd/.labels"
	echo "$HOME/gurd/.labels/"
}
