#!/usr/bin/env zsh
# Rename InterfaceLift.com wallpapers

# Exit on any command failures
set -e

mkdir -p ~/Pictures/Wallpapers/
cd ~/Pictures/Wallpapers/
autoload zmv
zmv -v ~/Downloads/'*_(*)_*x*'.jpg ~/Pictures/Wallpapers/'$1'.jpg
