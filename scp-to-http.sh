#!/bin/sh
# Uploads files to a HTTP server using SCP and prints the resulting URL.

USER="$1"
UPLOADHOST="$2"
WWWDIR="$3"
if [ -z "$5" ]
then
    FILEPATH="$4"
else
    HTTPPATH="$4"
    FILEPATH="$5"
fi

FILENAME=$(basename "$FILEPATH")
HTTPFILE=${FILENAME//" "/"%20"}

if [ -z "$HTTPPATH" ]
then
    HTTP="http://$UPLOADHOST/~$USER/$HTTPFILE"
else
    HTTP="$HTTPPATH/$HTTPFILE"
fi

SCP="$USER@$UPLOADHOST:$WWWDIR/"
scp "$FILEPATH" "$SCP"
if [ $? -ne 0 ]
then
    echo "$FILEPATH failed to upload to $SCP"
else
    echo "$FILEPATH uploaded to $HTTP"

    if [ $OSX ]
    then
        echo $HTTP | pbcopy
        echo "URL copied to clipboard."
    fi
fi
