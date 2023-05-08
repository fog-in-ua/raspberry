#!/bin/bash
wget https://raw.githubusercontent.com/fog-in-ua/max/main/configuration.yaml -P data
sudo docker run \
   --name zigbee2mqtt \
   --restart=unless-stopped \
#   --device=/dev/ttyUSB0 \
   --device=/dev/serial/by-id/usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20221201165558-if00:/dev/ttyACM0 \
   -p 8082:8082 \
   -v $(pwd)/data:/app/data \
   -v /run/udev:/run/udev:ro \
   -e TZ=Europe/Kyiv \
   koenkk/zigbee2mqtt
# curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/test.sh | sudo bash -
# usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20221201165558-if00 -> ../../ttyACM0
