#!/usr/bin/env bash

##################################################################################
# Raspberry Pi Router for usage with USB LTE stick                               #
#                                                                                #
# These instructions will help create a router from a raspberry pi.              #
# The goal is to setup eth0 as LAN and eth1 as WAN. This particular setup works  #
# with a raspberry pi B2 and a Huawei E3372 LTE USB stick.                       #
##################################################################################

set -e

sudo apt update
sudo apt install --yes git

sudo rm -Rf /tmp/rpi-router
sudo git clone https://github.com/brutesque/rpi-router /tmp/rpi-router

# Configuring the network
sudo cp /tmp/rpi-router/etc/sysctl.conf /etc/sysctl.conf
sudo sysctl -w net.ipv4.ip_forward=1

sudo cp /tmp/rpi-router/etc/network/interfaces /etc/network/interfaces

# Setup DHCP
sudo apt install --yes isc-dhcp-server
sudo cp /tmp/rpi-router/etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf
sudo cp /tmp/rpi-router/etc/default/isc-dhcp-server /etc/default/isc-dhcp-server

# Accessing the internet
sudo apt install --yes iptables
sudo bash /tmp/rpi-router/ipt.sh
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
sudo cp /tmp/rpi-router/etc/network/if-up.d/iptables /etc/network/if-up.d/iptables
sudo chmod +x /etc/network/if-up.d/iptables

# Reboot
sudo reboot
