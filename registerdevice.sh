#!/bin/bash

host="hostip"
user="user"
psw="psw"

#config 
t1="homeassistant/sensor/"
#temp
topic=$t1$1"/temperature/config"
state=""
echo $topic
mosquitto_pub -h $host -t $topic -r -u $user -P $psw -m '{ "device_class": "temperature", "name": "'$1' Température", "state_topic": "xiaomi/sensor/'$1'/state", "frc_upd": true, "uniq_id": "'$1'_Temperature", "unit_of_measurement": "°C", "value_template": "{{ value_json.temperature }}", "device": { "identifiers": [ "'$1'" ], "name": "'$1' sensors", "model": "Xiaomi Temp V2", "manufacturer": "Xiaomi" } }'

#hum
topic=$t1$1"/humidity/config"
echo $topic
mosquitto_pub -h $host -t $topic -r -u $user -P $psw -m '{"device_class": "humidity", "name": "'$1' Humidité", "state_topic": "xiaomi/sensor/'$1'/state", "frc_upd": true, "uniq_id": "'$1'_Humidity", "unit_of_measurement": "%", "value_template": "{{ value_json.humidity }}", "device": { "identifiers": [ "'$1'" ], "name": "'$1' sensors", "model": "Xiaomi Temp V2", "manufacturer": "Xiaomi" } }'

#batt
topic=$t1$1"/battlevel/config"
echo $topic
mosquitto_pub -h $host -t $topic -r -u $user -P $psw -m '{"device_class": "battery", "name": "'$1' Battery Level", "state_topic": "xiaomi/sensor/'$1'/state", "frc_upd": true, "uniq_id": "'$1'_BattLevel", "unit_of_measurement": "%", "value_template": "{{ value_json.batterylevel }}", "device": { "identifiers": [ "'$1'" ], "name": "'$1' sensors", "model": "Xiaomi Temp V2", "manufacturer": "Xiaomi" } }'
