packages TARGET:
	@just -f {{TARGET}} packages

tailscale:
	curl -fsSL https://tailscale.com/install.sh | sh
	sudo tailscale up

