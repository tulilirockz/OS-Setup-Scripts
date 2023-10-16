packages: nala
	nala install -y $(cat packages | xargs)

remove-snap:
	#!/usr/bin/bash
	if [ command -v snap &>/dev/null ] ; then
		snap remove firefox
		apt autoremove --purge snapd 
		rm -rf /var/cache/snapd
		apt-mark hold snapd
	fi

strip:
	#!/usr/bin/bash
	nala remove -y evince eog gnome-{characters,logs,font-viewer,text-editor,calculator} seahorse || exit 0

