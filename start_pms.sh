#!/bin/sh
#change these parameters in /etc/default/plexmediaserver
export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6
export PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver
export PLEX_MEDIA_SERVER_MAX_STACK_SIZE=3000
export PLEX_MEDIA_SERVER_TMPDIR=/tmp
export PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

mkdir -p $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR
export LD_LIBRARY_PATH="${PLEX_MEDIA_SERVER_HOME}"
export TMPDIR="${PLEX_MEDIA_SERVER_TMPDIR}"
export HOME=/tmp

rm -f $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex\ Media\ Server/*.pid

ulimit -s $PLEX_MAX_STACK_SIZE
# Add sleep - Possible fix for start on boot.
sleep 3

cd /usr/lib/plexmediaserver; ./Plex\ Media\ Server
