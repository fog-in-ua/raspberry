#!/bin/bash

##################################################################################################
# Редакція для Rasberry Pi                                       Copyright (C) 2023 Ihor Koliukh #
#                                                                                                #
# Ця програма є безкоштовним програмним забезпеченням: ви можете поширювати її та/або            #
# змінювати згідно з умовами GNU General Public License, опублікованої Free Software             #
# Foundation, версії 3 Ліцензії або (на ваш вибір) будь-якої пізнішої версії.                    #                                                           #
#                                                                                                #
# Ця програма розповсюджується в надії, що вона буде корисною, але БЕЗ ЖОДНИХ ГАРАНТІЙ; навіть   #
# без неявної гарантії ПРИДАТНОСТІ ДЛЯ ПРОДАЖУ чи ВІДПОВІДНОСТІ ДЛЯ КОНКРЕТНОЇ МЕТИ. Додаткову   #
# інформацію дивись у загальній публічній ліцензії GNU.                                          #
#                                                                                                #
# Ви мали отримати копію GNU General Public License разом із цією програмою.                     #
# Якщо ні, див <http://www.gnu.org/licenses/>.                                                   #
##################################################################################################
echo " "
echo " "
# System Upgrade
echo "----------------------------------------------------------------"
echo "Commence System Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y
sudo rpi-eeprom-update -d -a
echo "----------------------------------------------------------------"
echo "System Upgrade Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
# MC setup
echo "----------------------------------------------------------------"
echo "Commence MC Setup"
echo "----------------------------------------------------------------"
sudo apt-get update
sudo apt-get install -y mc
echo "----------------------------------------------------------------"
echo "MC Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
# Homebridge setup
echo "----------------------------------------------------------------"
echo "Commence Homebridge Setup"
echo "----------------------------------------------------------------"
#curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
#echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
#sudo apt-get update
#sudo apt-get install -y homebridge
echo "----------------------------------------------------------------"
echo "Homebridge Interface is reachable at homebridge.local:8581"
echo "----------------------------------------------------------------"
echo " "
echo " "
# Docker setup
echo "----------------------------------------------------------------"
echo "Commence Docker Setup"
echo "----------------------------------------------------------------"
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi
echo "----------------------------------------------------------------"
echo "Docker Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
# Portainer_agent setup
echo "----------------------------------------------------------------"
echo "Commence Portainer_agent Setup"
echo "----------------------------------------------------------------"
sudo docker run -d \
    -p 9001:9001 \
    --name portainer_agent \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    portainer/agent:2.18.2
echo "----------------------------------------------------------------"
echo "Portainer Interface is reachable at homebridge.local:9000"
echo "----------------------------------------------------------------"
echo " "
echo " "
# Portainer setup
#echo "----------------------------------------------------------------"
#echo "Commence Portainer Setup"
#echo "----------------------------------------------------------------"
#sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
#echo "----------------------------------------------------------------"
#echo "Portainer Interface is reachable at homebridge.local:9000"
#echo "----------------------------------------------------------------"
#echo " "
#echo " "
# Watch Tower setup
echo "----------------------------------------------------------------"
echo "Commence Watch Tower Setup"
echo "----------------------------------------------------------------"
sudo docker run --name="watchtower" -d --restart=always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
echo "----------------------------------------------------------------"
echo "Watch Tower Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
# HEIMDALL setup
echo "----------------------------------------------------------------"
echo "Commence HEIMDALL Setup"
echo "----------------------------------------------------------------"
#sudo docker run --name=heimdall -d --restart unless-stopped -v /home/kodestar/docker/heimdall:/config -e PGID=1000 -e PUID=1000 -p 8201:80 -p 8200:443 linuxserver/heimdall
echo "----------------------------------------------------------------"
echo "HEIMDALL Interface is reachable at homebridge.local:8201"
echo "----------------------------------------------------------------"
echo " "
echo " "
# Scrypted Install
echo "----------------------------------------------------------------"
echo "Commence Scypted Docker Setup"
echo "----------------------------------------------------------------"
#sudo docker run --name="scrypted" --network host -d --restart unless-stopped -v ~/.scrypted/volume:/server/volume koush/scrypted
echo "----------------------------------------------------------------"
echo "Scrypted Interface is reachable at https://localhost:10443/"
echo "----------------------------------------------------------------"
echo " "
echo " "
# MQTT Install
echo "----------------------------------------------------------------"
echo "Commence MQTT Setup"
echo "----------------------------------------------------------------"
#sudo mkdir mosquitto
#sudo mkdir mosquitto/config/
#sudo mkdir mosquitto/data/
#sudo wget https://raw.githubusercontent.com/fog-in-ua/max/main/mosquitto.conf -P /home/pi/mosquitto/config/
#sudo docker run -it --name MQTT --restart=always --net=host -tid -p 1883:1883 -v $(pwd)/mosquitto:/mosquitto/ eclipse-mosquitto
echo "----------------------------------------------------------------"
echo "MQTT Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
# Z2M setup
echo "----------------------------------------------------------------"
echo "Commence Zigbee2MQTT Setup"
echo "----------------------------------------------------------------"
#wget https://raw.githubusercontent.com/fog-in-ua/max/main/configuration.yaml -P data

#sudo docker run \
#   --name zigbee2mqtt \
#   --device=/dev/ttyACM0 \
#   --net host \
#   --restart always \
#   -v $(pwd)/data:/app/data \
#   -v /run/udev:/run/udev:ro \
#   -e TZ=Asia/Dubai \
#   koenkk/zigbee2mqtt
echo "----------------------------------------------------------------"
echo "Z2M Interface is reachable at homebridge.local:8082"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "ALL PACKAGES INSTALLED WITH NO ERRORS"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo "Rebooting Now"
sudo reboot
