#!/bin/sh 

grep --color --line-number -e "TODO\S*" "$@"
