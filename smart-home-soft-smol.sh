#!/bin/bash

#############################################################################################################
# Редакція для Rasberry Pi                                       Copyright (C) 2023 Ihor Koliukh            #
#                                                                                                           #
# curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/smart-home-soft-smol.sh | sudo bash - #
#    System Upgrade                                                                                         #
#    MC                                                                                                     #
#    Homebridge                                                                                             #
#    Docker                                                                                                 #
#       Portainer                                                                                           #
#       MQTT                                                                                                #
#       Zigbee2MQTT                                                                                         #
#                                                                                                           #
# Ця програма є безкоштовним програмним забезпеченням: ви можете поширювати її та/або                       #
# змінювати згідно з умовами GNU General Public License, опублікованої Free Software                        #
# Foundation, версії 3 Ліцензії або (на ваш вибір) будь-якої пізнішої версії.                               #
#                                                                                                           #
# Ця програма розповсюджується в надії, що вона буде корисною, але БЕЗ ЖОДНИХ ГАРАНТІЙ; навіть              #
# без неявної гарантії ПРИДАТНОСТІ ДЛЯ ПРОДАЖУ чи ВІДПОВІДНОСТІ ДЛЯ КОНКРЕТНОЇ МЕТИ. Додаткову              #
# інформацію дивись у загальній публічній ліцензії GNU.                                                     #
#                                                                                                           #
# Ви мали отримати копію GNU General Public License разом із цією програмою.                                #
# Якщо ні, див <http://www.gnu.org/licenses/>.                                                              #
#############################################################################################################
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   System Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y
sudo rpi-eeprom-update -d -a
echo "----------------------------------------------------------------"
echo "   System Upgrade Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   Static IP address"
echo "----------------------------------------------------------------"
sudo sh -c "echo ' ' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'nodhcp' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'interface eth0' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'static ip_address=10.10.10.108/24' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'static routers=10.10.10.1' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'static domain_name_servers=1.1.1.1 8.8.8.8' >> /etc/dhcpcd.conf"
echo "----------------------------------------------------------------"
echo "   Static IP address is set"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   MC Setup"
echo "----------------------------------------------------------------"
sudo apt-get install -y mc
echo "----------------------------------------------------------------"
echo "   MC Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "  Homebridge Setup"
echo "----------------------------------------------------------------"
curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
sudo apt-get update
sudo apt-get install -y homebridge
echo "----------------------------------------------------------------"
echo "  Homebridge Interface is reachable at homebridge.local:8581"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   Docker Setup"
echo "----------------------------------------------------------------"
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi
echo "----------------------------------------------------------------"
echo "   Docker Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   Portainer Setup in Docker"
echo "----------------------------------------------------------------"
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
echo "----------------------------------------------------------------"
echo "   Portainer Interface is reachable at homebridge.local:9000"
echo "----------------------------------------------------------------"
echo " "
#echo " "
#echo "----------------------------------------------------------------"
#echo "   Watch Tower Setup in Docker"
#echo "----------------------------------------------------------------"
#sudo docker run --name="watchtower" -d --restart=always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
#echo "----------------------------------------------------------------"
#echo "   Watch Tower Setup Completed"
#echo "----------------------------------------------------------------"
#echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   MQTT Setup in Docker"
echo "----------------------------------------------------------------"
sudo mkdir mosquitto
sudo mkdir mosquitto/config/
sudo mkdir mosquitto/data/
sudo wget https://raw.githubusercontent.com/fog-in-ua/config/main/mosquitto.conf -P /home/pi/mosquitto/config/
sudo docker run -it --name MQTT --restart=always --net=host -tid -p 1883:1883 -v $(pwd)/mosquitto:/mosquitto/ eclipse-mosquitto
echo "----------------------------------------------------------------"
echo "   MQTT Setup Completed in Docker"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   Zigbee2MQTT Setup in Docker"
echo "----------------------------------------------------------------"
wget https://raw.githubusercontent.com/fog-in-ua/config/main/configuration.yaml -P data

sudo docker run -d \
   --name zigbee2mqtt \
   --device=/dev/ttyACM0 \
   --net host \
   --restart always \
   -v $(pwd)/data:/app/data \
   -v /run/udev:/run/udev:ro \
   -e TZ=Asia/Dubai \
   koenkk/zigbee2mqtt
echo "----------------------------------------------------------------"
echo "   Z2M Interface is reachable at homebridge.local:8082"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   ALL PACKAGES INSTALLED WITH NO ERRORS"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo "Rebooting Now"
sudo reboot
