-------------------------------Update Packages with cron----------------------------------

create log file
> sudo touch /var/log/update_script.log
> sudo chmod 777 /var/log/update_script.log

Create and edit update.sh:
> sudo vim update.sh

Add:
#########

sudo apt-get update -y >> /var/log/update_script.log
sudo apt-get upgrade -y >> /var/log/update_script.log

#########

Change file mode:
> sudo chmod 755 update.sh

Add task to cron:

> sudo crontab -e
Add:
"@reboot sudo ~/update.sh
0 4 * * 6 sudo ~/update.sh"

Enable cron:
> sudo systemctl enable cron

------------------------------Monitor file change with cron-------------------------------
Create and edit ~/cronmonitor.sh like:
> vim ~/cronmonitor.sh

//CONTENT
#!/bin/bash

FILE="/home/mhasan/crontab_monitor"
FILE_TO_MONITOR="/etc/crontab"

MD5=$(sudo md5sum $FILE_TO_MONITOR)

if [ ! -f $FILE ]
then
	echo "$MD5" > $FILE
	exit 0;
fi;

if [ "$MD5" != "$(sudo cat $FILE)" ]
then
	echo "$MD5" > $FILE
	echo "$FILE_TO_MONITOR has been changed! 0_0! Be careful." | mail -s "$FILE_TO_MONITOR was changed!" root
fi;
//END OF CONTENT

Change file mode
> sudo chmod 755 cronmonitor.sh

Add task to crontab:
> sudo crontab -e
0 0 * * * sudo /home/mhasan/cronmonitor.sh
