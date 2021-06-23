#!/bin/bash

if [$# -ne 4]; 
    then echo "Incorrect number of parameters. Usage: unRegisterDevice.sh mqtthost user psw devicename"
    exit 2
fi

host=$1
user=$2
psw=$3
device=$4

#temp
mosquitto_pub -h $host -t "homeassistant/sensor/$device_temp/config" -r -u $user -P $psw -n
#hum
mosquitto_pub -h $host -t "homeassistant/sensor/$device_hum/config" -r -u $user -P $psw -n
#batt
mosquitto_pub -h $host -t "homeassistant/sensor/$device_btlv1/config" -r -u $user -P $psw -n
