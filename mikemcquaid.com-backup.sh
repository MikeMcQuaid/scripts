#!/bin/sh

# Exit on any command failures
set -e

LOCAL=/home/mike/Documents/Backup/Local
REMOTE=/home/mike/Documents/Backup/Remote

# Backup website files
cd /var/www/
tar jvcf $LOCAL/www.tar.bz2 *

# Backup private Git repositories
cd /home/mike/Documents/Git/
tar jvcf $LOCAL/git-private.tar.bz2 *

# Copy to NFS backup share
cp -v $LOCAL/www.tar.bz2 		$REMOTE
cp -v $LOCAL/git-private.tar.bz2 	$REMOTE
