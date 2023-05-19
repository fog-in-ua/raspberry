#!/bin/bash

#############################################################################################################
# Редакція для Rasberry Pi                                       Copyright (C) 2023 Ihor Koliukh            #
#                                                                                                           #
# curl -sk https://raw.githubusercontent.com/fog-in-ua/raspberry/main/huawei-E3372-lte-USB.sh | sudo bash - #
#    System Upgrade                                                                                         #
#    Static IP address in script                                                                            #
#    MC                                                                                                     #
#    Docker                                                                                                 #
#       Homebridge                                                                                          #
#       Scrypted                                                                                            #
#       Portainer_agent                                                                                     #
#       Portainer                                                                                           #
#       Watch Tower                                                                                         #
#       HEIMDALL                                                                                            #
#       MQTT                                                                                                #
#       Zigbee2MQTT                                                                                         #
#                                                                                                           #
# Ця програма є безкоштовним програмним забезпеченням: ви можете поширювати її та/або змінювати згідно з    #
# умовами GNU General Public License, опублікованої Free Software Foundation, версії 3 Ліцензії             #
# або (на ваш вибір) будь-якої пізнішої версії.                                                             #
#                                                                                                           #
# Ця програма розповсюджується в надії, що вона буде корисною, але БЕЗ ЖОДНИХ ГАРАНТІЙ; навіть без неявної  #
# гарантії ПРИДАТНОСТІ ДЛЯ ПРОДАЖУ чи ВІДПОВІДНОСТІ ДЛЯ КОНКРЕТНОЇ МЕТИ. Додаткову інформацію дивись у      #
# загальній публічній ліцензії GNU.                                                                         #
#                                                                                                           #
# Ви мали отримати копію GNU General Public License разом із цією програмою.                                #
# Якщо ні, див <http://www.gnu.org/licenses/>.                                                              #
#############################################################################################################
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "   Install HUAWEI E3372 LTE USB"
echo "----------------------------------------------------------------"
sudo apt-get install -y wvdial
sudo pico /etc/wvdial.conf
sudo sh -c "echo '[Dialer Defaults]' >> /etc/wvdial.conf
sudo sh -c "echo 'Init1 = ATZ' >> /etc/wvdial.conf
sudo sh -c "echo 'Init2 = ATQ0 V1 E1 S0=0' >> /etc/wvdial.conf
sudo sh -c "echo 'Modem Type = Analog Modem' >> /etc/wvdial.conf
sudo sh -c "echo 'Baud = 9600' >> /etc/wvdial.conf
sudo sh -c "echo 'New PPPD = yes' >> /etc/wvdial.conf
sudo sh -c "echo 'Modem = /dev/ttyUSB0' >> /etc/wvdial.conf
sudo sh -c "echo 'ISDN = 0' >> /etc/wvdial.conf
sudo sh -c "echo 'Phone = *99#' >> /etc/wvdial.conf
sudo sh -c "echo 'Password = internet' >> /etc/wvdial.conf
sudo sh -c "echo 'Username = internet' >> /etc/wvdial.conf
sudo sh -c "echo 'Stupid Mode = on' >> /etc/wvdial.conf
sudo wvdial

