#!/usr/bin/env zsh
# Rename InterfaceLift.com wallpapers

# Exit on any command failures
set -e

mkdir -p ~/Pictures/Wallpapers/
mv ~/Downloads/*_*_*x*.jpg ~/Pictures/Wallpapers/

cd ~/Pictures/Wallpapers/
autoload zmv
zmv -v '*_(*)_*x*.jpg' '$1.jpg'
