#!/bin/bash
# Garbage collect all Git repositories under the current directory.

CURRENT=$PWD
# Set to newline to loop over find output correctly on spaced paths.
IFS=$'\n'

function echorun {
    echo + $*
    $*
}

for SCM in $(find $CURRENT -name .git)
do
    DIRECTORY=$(dirname $SCM)
    cd $DIRECTORY
    echo == Garbage collecting $(basename $DIRECTORY)
    if [ -d .git ]
    then
        echorun git fsck
        echorun git gc
    fi
    echo
done
