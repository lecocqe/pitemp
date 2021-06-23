#!/bin/bash

host=$1
user=$2
psw=$3
device=$4

#config 
t1="homeassistant/sensor/"
#temp
topic=$t1$device"/temperature/config"
state=""
echo $topic
mosquitto_pub -h $host -t $topic -r -u $user -P $psw -m '{ "device_class": "temperature", "name": "'$device' Température", "state_topic": "xiaomi/sensor/'$devi0ce'/state", "frc_upd": true, "uniq_id": "'$device'_Temperature", "unit_of_measurement": "°C", "value_template": "{{ value_json.temperature }}", "device": { "identifiers": [ "'$device'" ], "name": "'$device' sensors", "model": "Xiaomi Temp V2", "manufacturer": "Xiaomi" } }'

#hum
topic=$t1$device"/humidity/config"
echo $topic
mosquitto_pub -h $host -t $topic -r -u $user -P $psw -m '{"device_class": "humidity", "name": "'$device' Humidité", "state_topic": "xiaomi/sensor/'$device'/state", "frc_upd": true, "uniq_id": "'$device'_Humidity", "unit_of_measurement": "%", "value_template": "{{ value_json.humidity }}", "device": { "identifiers": [ "'$device'" ], "name": "'$device' sensors", "model": "Xiaomi Temp V2", "manufacturer": "Xiaomi" } }'

#batt
topic=$t1$device"/battlevel/config"
echo $topic
mosquitto_pub -h $host -t $topic -r -u $user -P $psw -m '{"device_class": "battery", "name": "'$device' Battery Level", "state_topic": "xiaomi/sensor/'$device'/state", "frc_upd": true, "uniq_id": "'$device'_BattLevel", "unit_of_measurement": "%", "value_template": "{{ value_json.batterylevel }}", "device": { "identifiers": [ "'$device'" ], "name": "'$device' sensors", "model": "Xiaomi Temp V2", "manufacturer": "Xiaomi" } }'
