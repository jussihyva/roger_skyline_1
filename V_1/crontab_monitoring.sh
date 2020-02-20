#!/bin/bash

CRONTAB_MD5="/root/crontab_md5"
CRONTAB_FILE="/var/spool/cron/crontabs/root"

MD5=$(/usr/bin/md5sum $CRONTAB_FILE)

if [ ! -f $CRONTAB_MD5 ]
then
	echo "$MD5" > $CRONTAB_MD5
	exit 0;
fi;

if [ "$MD5" != "$(cat $CRONTAB_MD5)" ]
then
	echo "$MD5" > $CRONTAB_MD5
	echo "$CRONTAB_FILE has been changed!" | mail -s "$CRONTAB_FILE was changed!" root@localhost
fi;

