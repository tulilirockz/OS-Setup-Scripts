set allow-duplicate-recipes

system TARGET +OTHER:
	@just -f {{TARGET}}.justfile {{OTHER}}

packages TARGET:
	@just -f {{TARGET}} packages

tailscale:
	curl -fsSL https://tailscale.com/install.sh | sh
	sudo tailscale up

realtek-network:
	echo "make sure to have IWD installed!!!"
	sudo echo -e "[device]\nwifi.backend=iwd" | tee -a /etc/NetworkManager/conf.d/iwd.conf
	sudo echo -e "[device]\nwifi.scan-rand-mac-address=no" | tee -a /etc/NetworkManager/conf.d/rtl8xxxu_workaround.conf

positivo-touchscreen:
	git clone https://github.com/onitake/gsl-firmware /tmp/firmware
	mkdir -p /usr/lib/firmware/silead
	sudo cp -f /tmp/firmware/firmware/positivo/c464c/*.fw /usr/lib/firmware/silead
	rm /tmp/firmware

fish:
	chsh -s /usr/bin/fish
