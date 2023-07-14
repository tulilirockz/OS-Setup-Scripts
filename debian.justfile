!include justfile

mysystem: nala packages firewalld remote theming

sudo:
	echo "su -> sudo usermod -aG sudo $USER"

zram:
	sudo nala -y install zram-tools
	echo -e "ALGO=zstd\nPERCENT=60" | sudo tee -a /etc/default/zramswap
	sudo systemctl enable --now zramswap

remove-bloat:
	echo "run tasksel and remove debian-desktop-environment"
	

packages:
	sudo nala install -y $(cat debian.packages | xargs)

remote:
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
	sudo nala install -y gnome-shell-extension-{dashtodock,appindicator} 
