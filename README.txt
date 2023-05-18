    Налаштування статичної ІР адреси
sudo sh -c "echo 'nodhcp' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'interface eth0' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'static ip_address=10.10.10.108/24' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'static routers=10.10.10.1' >> /etc/dhcpcd.conf"
sudo sh -c "echo 'static domain_name_servers=1.1.1.1 8.8.8.8' >> /etc/dhcpcd.conf"

    Очистити файл
sudo echo -n > /etc/mosquitto/mosquitto.conf



    записати # nameserver 8.8.8.8 в кінецт файла
sudo sh -c "echo 'nameserver 8.8.8.8' >> /etc/resolv.conf"



apt install net-tools
systemctl reboot
systemctl poweroff

10.10.10.212
02:11:32:2e:e4:4f



    Mosquitto Debian repository
wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
sudo apt-key add mosquitto-repo.gpg.key
cd /etc/apt/sources.list.d/
sudo wget http://repo.mosquitto.org/debian/mosquitto-jessie.list
sudo wget http://repo.mosquitto.org/debian/mosquitto-stretch.list
sudo wget http://repo.mosquitto.org/debian/mosquitto-buster.list
apt-get update
apt-cache search mosquitto
apt-get install mosquitto



