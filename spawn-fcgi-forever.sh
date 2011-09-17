#!/bin/sh
while true
do
	spawn-fcgi -n -s /var/run/spawn-fcgi.sock -U www-data -G www-data\
		-P /var/run/spawn-fcgi.pid /usr/bin/php5-cgi
done
