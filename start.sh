#!/bin/bash

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

# Get the proper group membership, credit to http://stackoverflow.com/a/28596874/249107
TARGET_GID=$(stat -c "%g" /data)
EXISTS=$(cat /etc/group | grep $TARGET_GID | wc -l)

# Create new group using target GID and add plex user
if [ $EXISTS == "0" ]; then
  groupadd -g $ID tempgroup
  usermod -a -G tempgroup plex
else
  # GID exists, find group name and add
  GROUP=$(getent group $TARGET_GID | cut -d: -f1)
  usermod -a -G $GROUP plex
fi

su plex -c "/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf"

