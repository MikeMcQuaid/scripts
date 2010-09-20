#!/bin/sh
# Install all my dotfiles into my home directory
DOTFILESDIRREL=$(dirname $0)/dotfiles
cd $DOTFILESDIRREL
DOTFILESDIR=$(pwd -P)
for DOTFILE in *; do
	rm -iv ~/.$DOTFILE
	ln -sv $DOTFILESDIR/$DOTFILE ~/.$DOTFILE
done
