# ultimateinstall.sh
curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/ultimateinstall.sh | sudo bash -
    System Upgrade
    Docker Setup
    Portainer Setup
    Watch Tower Setup
    Scrypted Install
    MQTT Setup
    Zigbee2MQTT Setup
  
# налаштування Zigbee2MQTT
https://www.zigbee2mqtt.io/guide/installation/01_linux.html#optional-running-as-a-daemon-with-systemctl
    cd /opt/zigbee2mqtt
    sudo chown -R pi:pi /opt/zigbee2matt
    sudo ls -l /dev/serial/by-id
    cd /opt/zigbee2mqtt
    nano /opt/zigbee2mqtt/data/configuration.yaml
    
