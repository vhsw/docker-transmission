#!/bin/sh

if [ ! -f /config/settings.json ]; then
    cp /var/transmission/config/settings.json /config/settings.json
fi

/usr/bin/transmission-daemon --foreground --config-dir /config --log-info
