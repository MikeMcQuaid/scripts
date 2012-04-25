#!/bin/sh
# Install all my dotfiles into my home directory

DOTFILESDIRREL=$(dirname $0)/dotfiles
cd $DOTFILESDIRREL
DOTFILESDIR=$(pwd -P)
for DOTFILE in *; do
	HOMEFILE="$HOME/.$DOTFILE"
	[ -d $DOTFILE ] && DOTFILE="$DOTFILE/"
	DIRFILE="$DOTFILESDIR/$DOTFILE"
	# Matches Cygwin or MINGW
	if ! uname -s | grep -q "_NT-"
	then
		if [ -L "$HOMEFILE" ] && ! [ -d $DOTFILE ]
		then
			ln -sfv "$DIRFILE" "$HOMEFILE"
		else
			rm -rv "$HOMEFILE"
			ln -sv "$DIRFILE" "$HOMEFILE"
		fi
	else
		cp -rv "$DIRFILE" "$HOMEFILE"
	fi
done
