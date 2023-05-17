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
#sudo apt-get update && sudo apt-get upgrade -y
#sudo rpi-eeprom-update -d -a
echo "----------------------------------------------------------------"
echo "System Upgrade Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
# MC setup
echo "----------------------------------------------------------------"
echo "Commence MC Setup"
echo "----------------------------------------------------------------"
#sudo apt-get update
#sudo apt-get install -y mc
echo "----------------------------------------------------------------"
echo "MC Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
# Homebridge setup
echo "----------------------------------------------------------------"
echo "Commence Homebridge Setup"
echo "----------------------------------------------------------------"
curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
sudo apt-get update
sudo apt-get install -y homebridge
echo "----------------------------------------------------------------"
echo "Homebridge Interface is reachable at homebridge.local:8581"
echo "----------------------------------------------------------------"
echo " "
echo " "
# Scrypted setup
echo "----------------------------------------------------------------"
echo "Commence Scrypted Setup"
echo "----------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/koush/scrypted/main/install/local/install-scrypted-dependencies-linux.sh | sudo SERVICE_USER=$USER bash
echo "----------------------------------------------------------------"
echo "Scrypted Interface is reachable at  https://localhost:10443/"
echo "----------------------------------------------------------------"
echo " "
echo " "
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