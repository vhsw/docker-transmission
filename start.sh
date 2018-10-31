#!/bin/bash

mkdir -p /config

if [ ! -f /config/settings.json ]; then
    mv /etc/transmission-daemon/settings.json /config/settings.json
    rm /var/lib/transmission-daemon/info/settings.json
else
    rm /var/lib/transmission-daemon/info/settings.json
    rm /etc/transmission-daemon/settings.json
fi

ln -sf /config/settings.json /var/lib/transmission-daemon/info/settings.json
ln -sf /config/settings.json /etc/transmission-daemon/settings.json

/usr/bin/transmission-daemon --foreground --config-dir /config --log-info
