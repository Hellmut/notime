#!/bin/sh

GLOBAL_IP_FILE=$1

while [ 1 ]; do
    IP1=$(cat $GLOBAL_IP_FILE)
    IP2="";
    while [ 1 ]; do
        IP2="$(curl -s ifconfig.co)";
        if [[ $IP2 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
            break;
        else
            sleep 10;
        fi
    done;
     if [ "$IP1" != "$IP2" ]; then
      echo -e "Subject: IP alert: \n\n raspberry new ip: $IP2 " | ssmtp youraddress@gmail.com;
     fi
    echo "$IP2" >$GLOBAL_IP_FILE
    exit 0 # Remove this line if you want script to run forever
done
#EOF
