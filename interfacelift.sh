#!/usr/bin/env zsh
# Rename InterfaceLift.com wallpapers
autoload zmv
zmv -v '*_(*)_*x*.jpg' '$1.jpg'
