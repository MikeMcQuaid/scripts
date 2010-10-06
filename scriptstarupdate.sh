#!/bin/sh
# Update scripts from GitHub tarball

# Exit on any command failures
set -e

SCRIPTSDIRREL=$(dirname $0)
cd $SCRIPTSDIRREL
if [ -e .git ]
then
	echo "This scripts directory was checked out from Git so I won't update it."
	echo "If you want it updated from a tarball anyway, please delete .git first."
	exit 1
fi

wget http://github.com/mikemcquaid/Scripts/tarball/master -O scripts.tar.gz
tar --strip-components=1 -z -x -v -f scripts.tar.gz
rm scripts.tar.gz
