#!/bin/sh
# Update all Git and Subversion repositories under the current directory.

which git-up 1>/dev/null
GITUP=$?
CURRENT=$PWD
# Set to newline to loop over find output correctly on spaced paths.
IFS=$'\n'

function echorun {
    echo + $*
    $*
}

for SCM in $(find $CURRENT -name .git) $(find $CURRENT -name .svn)
do
    DIRECTORY=$(dirname $SCM)
    cd $DIRECTORY
    if [[ $DIRECTORY == */Tests/* ]] || [ -d ../.svn ]
    then
        continue
    fi
    echo == Updating $(basename $DIRECTORY)
    if [ -d .git/svn ]
    then
        echorun git svn fetch
        echorun git svn rebase
    elif [ -d .git ]
    then
        echorun git fetch --all
        if [ $GITUP -eq 0 ]
        then
            echorun git up
        else
            echorun git pull --rebase
        fi
    elif [ -d .svn ]
    then
        echorun svn update
    fi
    echo
done