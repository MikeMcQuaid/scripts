#!/bin/sh

# Exit on any command failures
set -e

LOCAL=/home/mike/Documents/Backup/Local
LOCAL=/home/mike/Documents/Backup/Remote

# Backup Wordpress files
cd /var/www/
tar jvcf $LOCAL/wordpress.tar.bz2 *

# Backup home directory web files
cd /home/mike/Sites/work/
tar jvcf $LOCAL/work.tar.bz2 *

# Backup Wordpress database
USERNAME=$(grep DB_USER /var/www/wp-config.php | awk -F "'" '{print $4}')
DATABASE=$(grep DB_NAME /var/www/wp-config.php | awk -F "'" '{print $4}')
PASSWORD=$(grep DB_PASSWORD /var/www/wp-config.php | awk -F "'" '{print $4}')
mysqldump -u "$USERNAME" --database "$DATABASE" --password="$PASSWORD" \
	| bzip2 -c > $LOCAL/wordpress.sql.bz2

# Backup private Git repositories
cd /home/mike/Documents/Git/
tar jvcf $LOCAL/git-private.tar.bz2 *

# Copy to NFS backup share
cp -v $LOCAL/wordpress.tar.bz2 		$REMOTE
cp -v $LOCAL/work.tar.bz2 		$REMOTE
cp -v $LOCAL/wordpress.sql.bz2 		$REMOTE
cp -v $LOCAL/git-private.tar.bz2 	$REMOTE
