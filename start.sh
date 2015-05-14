#!/bin/bash -eux

mkdir -p /config

if [ ! -f /config/settings.json ]; then
    mv /var/lib/transmission-daemon/info/settings.json /config/settings.json
else
    rm /var/lib/transmission-daemon/info/settings.json
fi

ln -sf /config/settings.json /var/lib/transmission-daemon/info/settings.json

/usr/bin/transmission-daemon --foreground --config-dir /config --log-info --username ${USERNAME} --peerport 45555 --password ${PASSWORD} --auth --watch-dir /watch --download-dir /downloads --incomplete-dir /incomplete
