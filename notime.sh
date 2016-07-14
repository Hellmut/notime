#!/bin/sh

GLOBAL_IP_FILE=$1

while [ 1 ]; do
    IP1=$(cat $GLOBAL_IP_FILE)
#    while [ -z "$IP1" ]; do
#       IP1="$(curl -s ifconfig.co)";
#       sleep 10;
#    done;
#    echo "IP1 = $IP1"

#    sleep 60;

    IP2="";
    while [ -z "$IP2" ]; do
        IP2="$(curl -s ifconfig.co)";
        sleep 10;
    done;
#    echo "IP2 = $IP2"

#    if [ -n "$IP1" ] && [ -n "$IP2" ]; then
     if [ "$IP1" != "$IP2" ]; then
      echo -e "Subject: IP alert: \n\n raspberry new ip: $IP2 " | ssmtp youraddress@gmail.com;
     fi
#    fi
    echo "$IP2" >$GLOBAL_IP_FILE
    exit 0 
#if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
done
#EOF
