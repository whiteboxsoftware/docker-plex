FROM krisdages/ubuntu-dumb-init:vivid
MAINTAINER Kris Dages <krisdages@git.whiteboxsoftware.net>

ENV PMS_VERSION="0.9.16.0"

RUN echo "deb http://shell.ninthgate.se/packages/debian plexpass main" > /etc/apt/sources.list.d/plexmediaserver.list && \
    curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add - && apt-get -q update && \
    apt-get install -qy --force-yes plexmediaserver && \
    apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV RUN_AS_ROOT="true" \
    CHANGE_DIR_RIGHTS="false"
ADD ./start_pms.sh /start_pms.sh
ENTRYPOINT ["/usr/bin/dumb-init", "-c", "/start_pms.sh"]
VOLUME ["/backup","/config","/config/Plex Media Server/Cache","/config/Plex Media Server/Logs","/media","/usr/lib/plexmediaserver/Resources"]
EXPOSE 32400
