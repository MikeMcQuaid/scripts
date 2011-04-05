#!/bin/sh
# Install all my dotfiles into my home directory

DOTFILESDIRREL=$(dirname $0)/dotfiles
cd $DOTFILESDIRREL
DOTFILESDIR=$(pwd -P)
for DOTFILE in *; do
	HOMEFILE="$HOME/.$DOTFILE"
	DIRFILE="$DOTFILESDIR/$DOTFILE"
	if [[ $(uname -s) != MINGW* ]]
	then
		if [[ -L "$HOMEFILE" ]]
		then
			ln -sfv "$DIRFILE" "$HOMEFILE"
		else
			rm -iv "$HOMEFILE"
			ln -sv "$DIRFILE" "$HOMEFILE"
		fi
	else
		cp -iv "$DIRFILE" "$HOMEFILE"
	fi
done
