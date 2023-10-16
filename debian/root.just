theming:
	#!/usr/bin/bash
	nala install -y gnome-shell-extension-{dashtodock,appindicator} yaru-theme-{gtk,icon,sound,gnome-shell}

strip:
	#!/usr/bin/bash
	sudo nala remove -y $(cat strip.pkgs | xargs)

packages:
	nala install -y $(cat packages | xargs)

sudo:
	echo "su -> sudo usermod -aG sudo $USER"

remove-bloat:
	echo "run tasksel and remove debian-desktop-environment"
	sleep 2
	sh strip.sh

sid:
	echo "remove deb-src + add contrib + nonfree to debian stuff, if you wanna use sid, replace bookworm with that /etc/apt/sources.list"
