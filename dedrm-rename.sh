#!/bin/sh
# Rename DeDRM mobi output files

# Exit on any command failures
set -e

mkdir -p ~/Documents/Books/DeDRM/
cd ~/Documents/Books/DeDRM/
for OLDFILENAME in *
do
	NEWFILENAME=$(echo $OLDFILENAME | sed -e 's/[A-Z0-9]*_\(.*\)/\1/' \
		-e 's/_/ /g' -e 's/EBOK //' -e 's/ nodrm\.mobi/.mobi/' -e 's/  / - /')
	mv -iv $OLDFILENAME "$NEWFILENAME"
done
