# ultimateinstall.sh
curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/ultimateinstall.sh | sudo bash -
    System Upgrade
    MC
    Homebridge
    Docker
    Portainer
    Watch Tower
    HEIMDALL
    Scrypted
    MQTT
    Zigbee2MQTT
    


# Portainer_agent

docker run -d \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:2.18.2
  
