#!/bin/bash

sudo docker run \
   --name zigbee2mqtt \
   --restart=unless-stopped \
   --device=/dev/ttyUSB0 \
   -p 8082:8082 \
   -v $(pwd)/data:/app/data \
   -v /run/udev:/run/udev:ro \
   -e TZ=Europe/Kyiv \
   koenkk/zigbee2mqtt
# curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/test.sh | sudo bash -
