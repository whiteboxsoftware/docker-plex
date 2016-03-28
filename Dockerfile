FROM krisdages/ubuntu-dumb-init:xenial
MAINTAINER Kris Dages <krisdages@git.whiteboxsoftware.net>


RUN echo "deb http://shell.ninthgate.se/packages/debian plexpass main" >> /etc/apt/sources.list && \
    curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add -
ENV RUN_AS_ROOT="true" \
    CHANGE_DIR_RIGHTS="false"
ADD ./start_pms.sh /start_pms.sh
ENTRYPOINT ["/usr/bin/dumb-init", "-c", "/start_pms.sh"]

#--Ports Used--
# 32400/tcp			API and web access, essential for Plex clients and Plex/Web management tool
# 1900/udp			Plex DLNA Server, optional, bypasses authentication features
# 32469/tcp			"    "    "
# 5353/udp			Bonjour/Avahi autodiscovery, optional -- possibly old versions only https://goo.gl/4QnTyh
# 32410-32414/udp	GDM Network Discovery, optional -- FAQ omits 32411 but this is apparently an oversight.

EXPOSE 32400 32469 "1900/udp" "5353/udp" "32410-32414/udp"

ENV PMS_DEPS_VERSION="0.9.16.3" \
	PMS_VERSION="0.9.16.3"
RUN  apt-get -q update && apt-get install -qy --force-yes plexmediaserver && \
    apt full-upgrade -qy && apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#ENV PMS_VERSION="0.9.16.3" \
#	PMS_DEB_URL=https://downloads.plex.tv/plex-media-server/0.9.16.3.1840-cece46d/plexmediaserver_0.9.16.3.1840-cece46d_amd64.deb
#RUN curl $PMS_DEB_URL > /tmp/pms.deb && dpkg -i --force-confdef /tmp/pms.deb && \
#    apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



VOLUME ["/backup","/config","/config/Plex Media Server/Cache","/config/Plex Media Server/Logs","/media"]
