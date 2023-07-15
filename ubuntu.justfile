!include justfile

mine: nala zram strip remove-snap flatpak packages remote

strip:
	sudo bash -c 'nala remove -y evince eog gnome-{characters,logs,font-viewer,text-editor,calculator} seahorse'

remove-snap:
	sudo snap remove firefox
	sudo apt autoremove --purge snapd 
	sudo rm -rf /var/cache/snapd
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
	printf "\nALGO=zstd\nPERCENT=60" | sudo tee -a /etc/default/zramswap
	sudo systemctl enable --now zramswap

packages:
	sudo nala install -y $(cat ubuntu.packages | xargs)

nala:
	sudo apt install -y nala 

remote:
	sudo nala install -y firewalld
	sudo systemctl enable --now firewalld
	sudo firewall-cmd --set-default-zone=home
	sudo firewall-cmd --add-service=ssh --permanent
	sudo firewall-cmd --add-service=cockpit --permanent
	sudo firewall-cmd --reload
	sudo systemctl enable --now ssh cockpit
	sudo systemctl enable --now --user gnome-remote-desktop.service
