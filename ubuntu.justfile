!include justfile


flatpak:
	sudo nala install -y flatpak gnome-software-plugin-flatpak
	flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

zram:
	sudo nala install -y zram-tools
	echo -e "ALGO=zstd\nPERCENT=60" | sudo tee -a /etc/default/zramswap
	sudo systemctl enable --now zramswap

packages:
	sudo nala install -y $(cat ubuntu.packages | xargs)

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

firewalld:
	sudo nala install -y firewalld
	systemctl enable --now firewalld
