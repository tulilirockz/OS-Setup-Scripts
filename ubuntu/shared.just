setup-zram:
	nala install -y zram-tools
	printf "\nALGO=zstd\nPERCENT=60" | tee -a /etc/default/zramswap
	systemctl enable --now zramswap

setup-flatpak:
	nala install -y flatpak gnome-software gnome-software-plugin-flatpak

setup-firewalld:
	#!/usr/bin/bash
	if [ ! command -v firewall-cmd &>/dev/null ] ; then
		nala install -y firewalld
		systemctl enable --now firewalld
	fi

setup-nala:
	#!/usr/bin/bash
	if [ ! command -v nala ] ; then
		apt install -y nala 
		nala fetch
	fi

setup-firewalld:
	sudo nala install -y firewalld
	systemctl enable --now firewalld

