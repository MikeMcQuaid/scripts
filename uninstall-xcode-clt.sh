#!/bin/sh
for FILE in $(pkgutil --only-files --files com.apple.pkg.DeveloperToolsCLI)
do
	FILE="/$FILE"
	[ -f $FILE ] || continue

	echo "Removing file: $FILE"
	rm -f $FILE
done

for DIRECTORY in $(pkgutil --only-dirs --files com.apple.pkg.DeveloperToolsCLI)
do
	DIRECTORY="/$DIRECTORY"
	[ -d $DIRECTORY ] || continue

	if [ "$(ls -A $DIRECTORY)" ]
	then
		continue
	fi

	DIRECTORY_REMOVED=1
	echo "Removing empty directory: $DIRECTORY"
	rm -rf $DIRECTORY
done

[ $DIRECTORY_REMOVED ] && echo "Please rerun to remove more CLT files" && exit 1
pkgutil --forget com.apple.pkg.DeveloperToolsCLI
echo "Removed all CLT files"
