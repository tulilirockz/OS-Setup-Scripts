!include justfile

mysystem: nala packages firewalld remote theming

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

sid:
	# nothing right now

firewalld:
	sudo nala install -y firewalld
	systemctl enable --now firewalld

theming:
	sudo nala install -y gnome-shell-extension-{dashtodock,appindicator} 
