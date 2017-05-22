#!/bin/bash

#update certs and installs

sudo service emqttd stop
sudo service apache2 stop

/home/homeassistant/certbot/certbot-auto renew

sleep 2

sudo systemctl stop home-assistant@homeassistant
sudo systemctl stop appdaemon@homeassistant
cd /opt/homeassistant/bin/
source activate
pip3 install --upgrade homeassistant
cd /opt/appdaemon
pip3 uninstall appdaemon
git pull origin
pip3 install .
sudo service emqttd start
sudo service apache2 start
sudo systemctl start home-assistant@homeassistant
sudo systemctl start appdaemon@homeassistant
