date >> /var/log/update_script.log 2>&1
sleep 60
apt-get update -y >> /var/log/update_script.log 2>&1
sleep 60
date >> /var/log/update_script.log 2>&1
apt-get upgrade -y >> /var/log/update_script.log 2>&1

