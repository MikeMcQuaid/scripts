#!/bin/sh
# Install all my dotfiles into my home directory

DOTFILESDIRREL=$(dirname $0)/dotfiles
cd $DOTFILESDIRREL
DOTFILESDIR=$(pwd -P)
for DOTFILE in *; do
	if [[ $(uname -s) != MINGW* ]]
	then
		rm -iv "$HOME/.$DOTFILE"
		ln -sv "$DOTFILESDIR/$DOTFILE" "$HOME/.$DOTFILE"
	else
		cp -iv "$DOTFILESDIR/$DOTFILE" "$HOME/.$DOTFILE"
	fi
done
