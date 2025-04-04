#!/usr/bin/env bash

set -e

OS=$(uname)
INSTALL_SCRIPT="https://nixos.org/nix/install"

function showHelp() {
	cat << EOF
Usage: $0 [command]

Commands:
	install, i	Install Nix Package Manager
	update, u	Update Nix Pacakge Manager
	remove, r	Uninstall Nix Package Manager
	config, c	Setup initial configuration for Nix Package Manager
EOF
}

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
	showHelp
	exit 1
fi

function install() {
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
}

function update() {
	sudo -i nix upgrade-nix
}

function uninstall() {
	/nix/nix-installer uninstall
}

function install_home_manager() {
	nix run home-manager/master -- init --switch
}

case $1 in
	install|i)
			install
		;;
	update|u)
			update
		;;
	remove|r)
			uninstall
		;;
	home_manager|hm)
			install_home_manager
		;;
	*)
		showHelp
		exit 1
		;;
esac
