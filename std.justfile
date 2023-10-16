set allow-duplicate-recipes

system TARGET +OTHER:
	@just -f {{TARGET}}/justfile {{OTHER}}

packages TARGET:
	@just -f {{TARGET}}/justfile packages

tailscale:
	curl -fsSL https://tailscale.com/install.sh | sh
	sudo tailscale up

realtek-network:
	echo "make sure to have IWD installed!!!"
	sudo echo -e "[device]\nwifi.backend=iwd" | tee -a /etc/NetworkManager/conf.d/iwd.conf
	sudo echo -e "[device]\nwifi.scan-rand-mac-address=no" | tee -a /etc/NetworkManager/conf.d/rtl8xxxu_workaround.conf

positivo-touchscreen:
	git clone https://github.com/onitake/gsl-firmware /tmp/firmware
	sudo mkdir -p /usr/lib/firmware/silead
	sudo cp -f /tmp/firmware/firmware/positivo/c464c/*.fw /usr/lib/firmware/silead
	rm -r /tmp/firmware

fish:
	chsh -s /usr/bin/fish
	curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
	fish -c 'omf install bobthefish'

yadm:
	mkdir -p $HOME/opt $HOME/.local/bin
	curl -fLo $HOME/opt/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm 
	chmod a+x $HOME/opt/yadm
	$HOME/opt/yadm clone https://github.com/tulilirockz/yadm-dotfiles.git
	$HOME/opt/yadm reset --hard HEAD
	mkdir -p $HOME/.local/bin
	mv $HOME/yadm $HOME/.local/bin
	@echo "run $HOME/.local/bin/yadm bootstrap to set up your computer"

flathub:
	flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

firewalld:
	firewall-cmd --set-default-zone=home
	firewall-cmd --add-service=ssh --permanent
	firewall-cmd --add-service=cockpit --permanent
	firewall-cmd --reload

remote-access:
	systemctl enable --now ssh cockpit
	systemctl enable --now --user gnome-remote-desktop.service

disable-swap:
	#!/bin/bash
	sed -i '/ swap / s/^/#/' /etc/fstab
	swapoff -a


