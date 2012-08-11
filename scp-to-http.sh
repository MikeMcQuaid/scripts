#!/bin/sh
# Uploads files to a HTTP server using SCP and prints the resulting URL.

USER="$1"
UPLOADHOST="$2"
WWWDIR="$3"
if [ -z "$5" ]
then
    FILEPATH="$4"
else
    MOVEPATH="$4"
    FILEPATH="$5"
fi

FILENAME=$(basename "$FILEPATH")
HTTPFILE=${FILENAME//" "/"%20"}
HTTP="http://$UPLOADHOST/~$USER/$HTTPFILE"

SCP="$USER@$UPLOADHOST:$WWWDIR/"
scp "$FILEPATH" "$SCP"
[ $? -ne 0 ] && echo "$FILEPATH failed to upload to $SCP" && exit 1

echo "$FILEPATH uploaded to $HTTP"

if [ $OSX ]
then
    echo $HTTP | pbcopy
    echo "URL copied to clipboard."
fi

[ -n "$MOVEPATH" ] && mv -v "$FILEPATH" "$MOVEPATH"
