# ultimateinstall.sh
curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/home-control.sh | sudo bash -
    System Upgrade
    MC
    Homebridge
    Docker
    Portainer_agent
    Portainer
    Watch Tower
    HEIMDALL
    Scrypted
    MQTT
    Zigbee2MQTT

nodhcp
interface eth0
static ip_address=10.10.10.108/24
static routers=10.10.10.1
static domain_name_servers=1.1.1.1 8.8.8.8

записати # nameserver 8.8.8.8 в кінецт файла
echo "# nameserver 8.8.8.8" >> /home/ihor.koliukh/dhcpd.conf




apt install net-tools
systemctl reboot
systemctl poweroff

10.10.10.212
02:11:32:2e:e4:4f
