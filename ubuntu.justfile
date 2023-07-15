!include justfile

mine: nala zram strip remove-snap flatpak packages remote

strip:
	sudo bash -c 'nala remove -y evince eog gnome-{characters,logs,font-viewer,text-editor,calculator} seahorse'

remove-snap:
	sudo rm -rf /var/cache/snapd/
	sudo apt autoremove --purge snapd 
	rm -fr ~/snap
	sudo apt-mark hold snapd

snap:
	snap remove firefox 
	snap install chromium
	snap refresh snap-store --channel=latest/edge

flatpak:
	sudo nala install -y flatpak gnome-software gnome-software-plugin-flatpak
	flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

zram:
	sudo nala install -y zram-tools
	echo -e "ALGO=zstd\nPERCENT=60" | sudo tee -a /etc/default/zramswap
	sudo systemctl enable --now zramswap

packages:
	sudo nala install -y $(cat ubuntu.packages | xargs)

nala:
	sudo apt install -y nala 

remote:
	sudo nala install -y firewalld
	systemctl enable --now firewalld
	firewall-cmd --set-default-zone=home
	firewall-cmd --add-service=ssh --permanent
	firewall-cmd --add-service=cockpit --permanent
	firewall-cmd --reload
	systemctl enable --now ssh cockpit
	systemctl enable --now --user gnome-remote-desktop.service
