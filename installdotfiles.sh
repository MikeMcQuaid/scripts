#!/bin/sh
# Install all my dotfiles into my home directory

DOTFILESDIRREL=$(dirname $0)/dotfiles
cd $DOTFILESDIRREL
DOTFILESDIR=$(pwd -P)
for DOTFILE in *; do
	rm -iv "$HOME/.$DOTFILE"
	if [[ $TERM != "cygwin" ]]
	then
		ln -sv "$DOTFILESDIR/$DOTFILE" "$HOME/.$DOTFILE"
	else
		cp -v "$DOTFILESDIR/$DOTFILE" "$HOME/.$DOTFILE"
	fi
done
