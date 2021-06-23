# pitemp

The goal of this is to add Xiaomi Mijia LYWSD03MMC into Home Assistant via mqtt. In my setup, i have a Raspberry pi used as ble gateway and mqtt client.
in order to get this done. I use a script (scan2.py) that provides a list of the mac addresses a the devices around the house. Then i register the device with "registerdevice.sh" script. Then via crontab, a script update the state of the sensor in home assistant.

##### 1. Scan2.py
scan for Xiaomi temperature sensor v2 BLE devices. Thank you to [Fanjoe](https://www.fanjoe.be/?p=3911) 
  
##### 2. Register Device
`usage: registerdevice.sh host user psw devicenameyouwant`
  
##### 3. Unregister Device
`usage: unregisterdevice.sh host user psw devicenameyouwant`
  
##### 4. update State
`updateStat.sh host user psw devicenameyouwant macaddress`
