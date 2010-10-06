#!/bin/sh

# Exit on any command failures
set -e

# Set environment
export HOMEBREW="/usr/local"
export KDEDIR="~/Documents/KDE/install"
export KDEDIRS="$KDEDIR:$HOMEBREW"
export PATH="$KDEDIR/bin:$PATH"
export QT_PLUGIN_PATH="$KDEDIR/lib/kde4/plugins:$QT_PLUGIN_PATH"

# Find or launch D-Bus
dbus-cleanup-sockets >/dev/null
if [[ $(ps x) == *dbus-daemon* ]]
then
	DBUS_SESSION_BUS_ADDRESS="unix:path="
	DBUS_SESSION_BUS_ADDRESS+=$(echo /tmp/dbus-*)
	export DBUS_SESSION_BUS_ADDRESS
	DBUS_SESSION_BUS_PID=$(ps x| awk '/dbus/ {print $1}')
	export DBUS_SESSION_BUS_PID
else
	export `dbus-launch`
fi

alias cmakekde="cmake .. -DKDE4_BUILD_TESTS=TRUE -DCMAKE_PREFIX_PATH=$HOMEBREW -DCMAKE_BUILD_TYPE=debugfull -DCMAKE_INSTALL_PREFIX=$KDEDIR -DBUNDLE_INSTALL_DIR=$KDEDIR/bin"
