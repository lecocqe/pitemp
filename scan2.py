from bluepy.btle import Scanner, DefaultDelegate

class ScanDelegate(DefaultDelegate):
    def __init__(self):
        DefaultDelegate.__init__(self)

    def handleDiscovery(self, dev, isNewDev, isNewData):
        if isNewDev:
             hdisc=1
#            print("Discovered device", dev.addr)
        elif isNewData:
             hdisc=2
#            print ("Received new data from", dev.addr)

scanner = Scanner().withDelegate(ScanDelegate())
devices = scanner.scan(10.0)

for dev in devices:
#    print(dev.addr, dev.rssi)

#    print( "Device %s (%s), RSSI=%d dB" % (dev.addr, dev.addrType,     dev.rssi))
    for (adtype, desc, value) in dev.getScanData():
       if adtype == 9:
          if value == 'LYWSD03MMC':
             print(dev.addr)

#    for (adtype, desc, value) in dev.getScanData():
#        print(adtype, desc, value)
#   print(dev.addr, dev.rssi)
