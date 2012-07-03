#!/bin/sh
# Uninstall all non-whitelisted Homebrew formulae

# Exit on any command failures
set -e

BREW_CLEAN_WHITELIST=~/.brew-clean-whitelist
[ -s $BREW_CLEAN_WHITELIST ]
BREW_LIST=$TMPDIR/brew-list
[ -s $BREW_LIST ]

brew list > $BREW_LIST
comm -13 $BREW_CLEAN_WHITELIST $BREW_LIST | xargs brew uninstall
rm $BREW_LIST
