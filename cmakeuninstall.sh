#!/bin/sh
# Make uninstall hack for CMake
rm `make install | grep Installing | awk '{print $3}'`
