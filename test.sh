#!/bin/bash
docker run --net=host --name=homebridge -v $(pwd)/homebridge:/homebridge oznu/homebridge:latest
docker-compose up -d

# curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/test.sh | sudo bash -
# usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20221201165558-if00 -> ../../ttyACM0

#sudo apt update
#sudo apt upgrade
#sudo apt install mosquitto mosquitto-clients

#sudo systemctl status mosquitto
# Вы должны увидеть текст "active (running)", если служба запущена правильно.
# https://pimylifeup.com/raspberry-pi-mosquitto-mqtt-server/

