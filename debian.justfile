!include justfile

mysystem: nala remove-bloat flatpak packages firewalld remote theming

flatpak:
	sudo nala install -y flatpak gnome-software-plugin-flatpak
	flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo:
	echo "su -> sudo usermod -aG sudo $USER"

zram:
	sudo nala install -y zram-tools
	echo -e "ALGO=zstd\nPERCENT=60" | sudo tee -a /etc/default/zramswap
	sudo systemctl enable --now zramswap

remove-bloat:
	echo "run tasksel and remove debian-desktop-environment"
	sleep 2
	sh debian.strip.sh

packages:
	sudo nala install -y $(cat debian.packages | xargs)

remote: firewalld
	systemctl enable --now sshd cockpit
	systemctl enable --now --user gnome-remote-desktop.service
	firewall-cmd --set-default-zone=home
	firewall-cmd --add-service=sshd --permanent
	firewall-cmd --add-service=cockpit --permanent
	firewall-cmd --reload

nala:
	sudo apt install -y nala 
	sudo nala fetch

sid:
	echo "remove deb-src + add contrib + nonfree to debian stuff, if you wanna use sid, replace bookworm with that /etc/apt/sources.list"

firewalld:
	sudo nala install -y firewalld
	systemctl enable --now firewalld

theming:
	bash -c "sudo nala install -y gnome-shell-extension-{dashtodock,appindicator} yaru-theme-{gtk,icon,sound,gnome-shell}" 
