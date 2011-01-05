#!/bin/sh
# Update all Git and Subversion repositories under the current directory.

which git-up 1>/dev/null
GITUP=$?
CURRENT=$PWD

function echorun {
    echo + $*
    $*
}

for GIT in $(find $CURRENT -name .git)
do
    DIRECTORY=$(dirname $GIT)
    cd $DIRECTORY
    echo == Updating $(basename $DIRECTORY)
    if [ -d .git/svn ]
    then
        echorun git svn fetch
        echorun git svn rebase
    else
        if [ $GITUP -eq 0 ]
        then
            echorun git up
        else
            echorun git fetch --all
            echorun git pull --rebase
        fi
    fi
    echo
done

for SVN in $(find $CURRENT -name .svn)
do
    DIRECTORY=$(dirname $SVN)
    cd $DIRECTORY
    if [ -d ../.svn ]
    then
        continue
    fi
    echo == Updating $(basename $DIRECTORY)
    echorun svn update
    echo
done