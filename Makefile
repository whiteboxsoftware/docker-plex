default:
	docker build --rm=true --force-rm=true -t krisdages/plex-mediaserver .
nocache:
	docker build --rm=true --force-rm=true --no-cache -t krisdages/plex-mediaserver .
next:
	docker build --rm=true --force-rm=true -t krisdages/plex-mediaserver:next .
next-nocache:
	docker build --rm=true --force-rm=true --no-cache -t krisdages/plex-mediaserver:next .
