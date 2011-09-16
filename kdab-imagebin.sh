#!/bin/sh

FILE="$1"
USER=$(whoami)
PASSWORD=$(security 2>&1 find-internet-password -gs imagebin.kdab.com | grep password | cut -f2 -d\")

curl --user $USER:$PASSWORD -F task=post -F name= -F link= -F field1=$USER -F field2= -F field3= -F field4= -F file=@"$FILE" -F password=$PASSWORD -F submit=Submit https://imagebin.kdab.com/wakaba.pl

open https://imagebin.kdab.com/
