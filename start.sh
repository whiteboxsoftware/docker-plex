#!/bin/sh

mkdir -p /config/logs/supervisor
chown -R plex: /config

touch /supervisord.log
touch /supervisord.pid
chown plex: /supervisord.log /supervisord.pid

rm -rf /var/run/*
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

mkdir -p /var/run/dbus
chown messagebus:messagebus /var/run/dbus
dbus-uuidgen --ensure
dbus-daemon --system --fork
sleep 1

avahi-daemon -D
sleep 1

#Removed till I can think of a better method to fix rights
#
#su plex -c "/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf"

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
