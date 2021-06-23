#!/bin/bash

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
