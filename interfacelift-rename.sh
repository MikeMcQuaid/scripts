#!/usr/bin/env zsh
# Rename InterfaceLift.com wallpapers

# Exit on any command failures
set -e

cd ~/Pictures/Wallpapers/
autoload zmv
zmv -v '*_(*)_*x*.jpg' '$1.jpg'
