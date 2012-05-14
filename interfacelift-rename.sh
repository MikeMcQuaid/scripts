#!/usr/bin/env zsh
# Rename InterfaceLift.com wallpapers

# Exit on any command failures
set -e

autoload zmv
zmv -v ~/Downloads/'*_(*)_*x*'.jpg ~/Dropbox/Wallpapers/'$1'.jpg
