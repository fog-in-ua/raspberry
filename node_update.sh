#!/bin/bash

#############################################################################
# https://raw.githubusercontent.com/fog-in-ua/raspberry/main/node_update.sh #
#############################################################################

sudo apt-get update && sudo apt-get upgrade -y 
sudo hb-service update-node
sudo npm install -g npm
sudo reboot
