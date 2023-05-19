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
#echo " "
#echo "----------------------------------------------------------------"
#echo "   System Upgrade"
#echo "----------------------------------------------------------------"
#sudo apt-get update && sudo apt-get upgrade -y
#sudo rpi-eeprom-update -d -a
#echo "----------------------------------------------------------------"
#echo "   System Upgrade Completed"
#echo "----------------------------------------------------------------"
#echo " "
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
#echo " "
#echo "----------------------------------------------------------------"
#echo "   Portainer Setup in Docker"
#echo "----------------------------------------------------------------"
#sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
#echo "----------------------------------------------------------------"
#echo "   Portainer Interface is reachable at homebridge.local:9000"
#echo "----------------------------------------------------------------"
#echo " "
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
