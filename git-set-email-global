#!/bin/sh
# Set email for all git repositories under the current directory.

EMAIL="mike@alltrails.com"

CURRENT=$PWD
# Set to newline to loop over find output correctly on spaced paths.
IFS="
"

for SCM in $(find $CURRENT -name .git)
do
    DIRECTORY=$(dirname $SCM)
    cd $DIRECTORY
    if [ -d .git ]
    then
        if ! git config --local --get user.email >/dev/null
        then
           echo == Setting email to $EMAIL for $(basename $DIRECTORY)
           git config --local --add user.email $EMAIL
        fi
    fi
done
