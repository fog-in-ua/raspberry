#!/bin/bash

#######################################################################################################
# Редакція для Rasberry Pi                                       Copyright (C) 2023 Ihor Koliukh      #
#                                                                                                     #
# curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/soft-in-system.sh | sudo bash - #
#    System Upgrade                                                                                   #
#    Static IP address                                                                                #
#    MC                                                                                               #
#    Homebridge                                                                                       #
#    Scrypted                                                                                         #
#    HEIMDALL                                                                                         #
#    MQTT                                                                                             #
#    Zigbee2MQTT                                                                                      #
#                                                                                                     #
# Ця програма є безкоштовним програмним забезпеченням: ви можете поширювати її та/або                 #
# змінювати згідно з умовами GNU General Public License, опублікованої Free Software                  #
# Foundation, версії 3 Ліцензії або (на ваш вибір) будь-якої пізнішої версії.                         #
#                                                                                                     #
# Ця програма розповсюджується в надії, що вона буде корисною, але БЕЗ ЖОДНИХ ГАРАНТІЙ; навіть        #
# без неявної гарантії ПРИДАТНОСТІ ДЛЯ ПРОДАЖУ чи ВІДПОВІДНОСТІ ДЛЯ КОНКРЕТНОЇ МЕТИ. Додаткову        #
# інформацію дивись у загальній публічній ліцензії GNU.                                               #
#                                                                                                     #
# Ви мали отримати копію GNU General Public License разом із цією програмою.                          #
# Якщо ні, див <http://www.gnu.org/licenses/>.                                                        #
#######################################################################################################
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
sudo apt-get update
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
echo "  Scypted Setup"
echo "----------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/koush/scrypted/main/install/local/install-scrypted-dependencies-linux.sh | sudo SERVICE_USER=$USER bash
echo "----------------------------------------------------------------"
echo "  Scrypted Interface is reachable at https://localhost:10443"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   HEIMDALL Setup"
echo "----------------------------------------------------------------"
#
echo "----------------------------------------------------------------"
echo "   HEIMDALL Interface is reachable at homebridge.local:8201"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   MQTT Setup in Docker"
echo "----------------------------------------------------------------"
sudo apt update && sudo apt upgrade &ndash;y
sudo apt install mosquitto mosquitto-clients -y
sudo systemctl enable mosquitto.service
mosquitto -v
#sudo mosquitto_passwd -c /etc/mosquitto/passwd ravi
sudo nano /etc/mosquitto.conf

per_listener_settings true

pid_file /run/mosquitto/mosquitto.pid

persistence true
persistence_location /var/lib/mosquitto/
log_dest file /var/log/mosquitto/mosquitto.log

include_dir /etc/mosquitto/conf.d
allow_anonymous true
listener 1883 

sudo systemctl restart mosquitto
sudo systemctl status mosquitto
echo "----------------------------------------------------------------"
echo "   MQTT Setup Completed in Docker"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   Zigbee2MQTT Setup in Docker"
echo "----------------------------------------------------------------"
#
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
