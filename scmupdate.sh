#!/bin/sh
# Update all Git and Subversion respostories under the current directory.

CURRENT=$PWD
for GIT in $(find $CURRENT -name .git)
do
    DIRECTORY=$(dirname $GIT)
    cd $DIRECTORY
    echo == Updating $(basename $DIRECTORY)
    if [ -d .git/svn ]
    then
        echo = git svn rebase
        git svn rebase
    else
        echo = git fetch
        git fetch
        echo = git pull --rebase
        git pull --rebase
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
    echo = svn update
    svn update
    echo
done