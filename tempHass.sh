#!/bin/bash

Topic=$1
MACadd=$2

echo "----"$(date)"----"
echo $1 ': ' $2
hnd38=$(timeout 15 gatttool -b $MACadd --char-write-req --handle='0x0038' --value="0100" --listen | grep --max-count=1 "Notification handle")
# Notification handle = 0x0036 value: 7c 08 2a 97 0c

if !([ -z "$hnd38" ])
then
    echo "Reading Mijia ..."

    temperature=${hnd38:39:2}${hnd38:36:2}
    temperature=$((16#$temperature))
    if [ "$temperature" -gt "10000" ];
    then
        temperature=$((-65536 + $temperature))
    fi
    temperature=$(echo "scale=2;$temperature/100" | bc)

    humidity=${hnd38:42:2}
    humidity=$((16#$humidity))

    voltage=${hnd38:48:2}${hnd38:45:2}
    voltage=$((16#$voltage))
    voltage=$(echo "scale=3;$voltage/1000" | bc)
    battlvl=$(echo "scale=1;($voltage-2.1)*100" | bc)

    # Battery Level : 0x2A19
    # handle = 0x001b, uuid = 00002a19-0000-1000-8000-00805f9b34fb

    hnd1b=$(gatttool --device=$MACadd --char-read -a 0x1b)
    # Characteristic value/descriptor: 63
    battery=${hnd1b:33:2}
    battery=$((16#$battery))

    # Firmware Revision String : 0x2A26
    # handle = 0x0012, uuid = 00002a26-0000-1000-8000-00805f9b34fb

    hnd12=$(gatttool --device=$MACadd --char-read -a 0x12)
    # Characteristic value/descriptor: 31 2e 30 2e 30 5f 30 31 30 36 00
    firmware=$(echo "'$hnd12'" | cut -c34-65 | xxd -r -p)

    # Device Name : 0x2A00
    # handle = 0x0003, uuid = 00002a00-0000-1000-8000-00805f9b34fb

    hnd03=$(gatttool --device=$MACadd --char-read -a 0x03)
    # Characteristic value/descriptor: 4c 59 57 53 44 30 33 4d 4d 43 00
    name=$(echo "'$hnd03'" | cut -c34-65 | xxd -r -p)

    # Hardware Revision String : 0x2A27
    # handle = 0x0014, uuid = 00002a27-0000-1000-8000-00805f9b34fb

    hnd14=$(gatttool --device=$MACadd --char-read -a 0x14)
    # Characteristic value/descriptor: 42 31 2e 34
    revision=$(echo "'$hnd14'" | cut -c34-45 | xxd -r -p)

    # Affichage des données

    # echo "Reading Mijia..."
    echo "Hardware: {Firmware Version:$firmware / Hardware Revision:$revision / BT Name:$name / Battery Level:$battery}"
    echo "Sensors: {Temperature:$temperature / Humidity:$humidity / Voltage:$voltage / Battery:$battlvl}"

    # Envoi vers HASS
    host='192.168.1.6'
    user='eric'
    psw='LECOCQ402'

    # xiaomi/sensor/theo/state
    mosquitto_pub -h $host -t "xiaomi/sensor/$Topic/state" -r -d -u $user -P $psw -m "{ \"temperature\": $temperature, \"humidity\": $humidity, \"batterylevel\": $battlvl }"

    echo "---END---"

else

    echo "Mijia error"
    echo "---END---"
    exit 1

fi
#echo "---END---"
