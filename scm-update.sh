#!/bin/sh
# Update all Git and Subversion repositories under the current directory.

CURRENT=$PWD
# Set to newline to loop over find output correctly on spaced paths.
IFS="
"

echorun() {
  echo + "$@"
  $*
}

for SCM in $(find -L $CURRENT -name .git) $(find $CURRENT -name .svn)
do
  DIRECTORY=$(dirname $SCM)
  cd $DIRECTORY
  if [ -d ../.svn ] || echo $DIRECTORY | grep -q "vendor/ruby"
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
    if [ -n "$(git remote -v)" ]; then
      echorun git pull
      git branch --merged | grep -v 'master' | grep -v '*' | xargs -n 1 git branch -d
    fi
  elif [ -d .svn ]
  then
    echorun svn update
  fi
  echo
done
