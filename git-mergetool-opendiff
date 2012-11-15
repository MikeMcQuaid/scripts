#!/bin/sh
# Script to be used with git mergetool to handle opendiff nicely.
if [ $# != 6 ]
then
    echo "ERROR: Don't call this script directly; use 'git mergetool' instead."
    exit
fi

# Kill all instances of FileMerge already running
ps x | grep FileMerge | grep -v grep | cut -d' ' -f1 | xargs kill
# Pipe output from opendiff to make it wait for FileMerge to exit
opendiff "$@" | cat
