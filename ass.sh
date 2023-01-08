#! /usr/bin/env bash

PROJECT_ROOT="${PWD}"
SCRIPT_NAME=$(basename "$0")
USER_NAME=$(whoami)

trap "printf '\n\nUser aborted, exiting...\n\n'; exit 127" SIGINT

declare -a REPOS=(
	"void-repo-multilib"
	"void-repo-multilib-nonfree"
	"void-repo-nonfree"
)

declare -a PACKAGES=(
	"NetworkManager"
	"Vulkan-Tools"
	"bat"
	"blueman"
	"caja"
	"ccsm"
	"compiz-plugins-extra"
	"compiz-plugins-main"
	"conky"
	"curl"
	"dbus"
	"dunst"
	"elinks"
	"elogind"
	"emerald"
	"engrampa"
	"eom"
	"ffmpegthumbnailer"
	"firefox-esr"
	"freetype-32bit"
	"fzf"
	"git"
	"gnome-keyring"
	"hsetroot"
	"htop"
	"jq"
	"lm_sensors"
	"mate-polkit"
	"micro"
	"most"
	"mpg123"
	"most"
	"mpv"
	"ncdu"
	"network-manager-applet"
	"ntfs-3g"
	"nvidia"
	"nvidia-libs"
	"nvidia-libs-32bit"
	"openvpn"
	"p7zip"
	"pavucontrol"
	"pluma"
	"psmisc"
	"pulseaudio"
	"qemu"
	"redshift-gtk"
	"rofi"
	"setxkbmap"
	"stalonetray"
	"thunderbird"
	"tmux"
	"tree"
	"unzip"
	"virt-manager"
	"vkd3d"
	"vscode"
	"vulkan-loader"
	"vulkan-loader-32bit"
	"wget"
	"xclip"
	"xcursor-vanilla-dmz-aa"
	"xdm"
	"xorg-minimal"
	"xrandr"
	"xrdb"
	"xsel"
	"xsettingsd"
	"xterm"
	"xz"
	"youtube-dl"
	"zstd"
)

check_previleges () {
    printf "\nValidating run previleges... user ${USER_NAME} (${EUID})\n"
    if [ "${EUID}" -eq 0 ]; then
      printf "Please run as a regular user to continue...\n\n"
      exit 127
    fi
}

update_system () {
    printf "\nUpdating system...\n"
    sudo xbps-install -Su --yes
}

enable_repos () {
    printf "\Enabling repositories...\n"
    for REPO in "${REPOS[@]}"; do
        printf "${REPO}\n"
        sudo xbps-install "${REPO}" --yes
    done
}

install_packages () {
    printf "\nInstalling packages...\n"
    for PACKAGE in "${PACKAGES[@]}"; do
        printf "${PACKAGE}\n"
        sudo xbps-install "${PACKAGE}" --yes
    done
}

copy_system_configuration () {
    printf "\nCopying system configurations...\n"
    sudo cp -r -v "${PROJECT_ROOT}"/etc/* /etc/ \
		&& sudo update-grub
    sudo cp -r -v "${PROJECT_ROOT}"/usr/* /usr/
}

disable_system_services () {
	printf "\nDisabling system services...\n"
 	[ -r /var/service/dhcpcd ] \
		&& sudo rm /var/service/dhcpcd
	[ -r /var/service/wpa_supplicant ] \
		&& sudo rm /var/service/wpa_supplicant
}

enable_system_services () {
    printf "\nEnabling system services...\n"
	sudo ln -s /etc/sv/NetworkManager /var/service
	sudo ln -s /etc/sv/dbus /var/service
	sudo ln -s /etc/sv/polkitd /var/service
	sudo ln -s /etc/sv/xdm /var/service
	sudo ln -s /etc/sv/bluetoothd /var/service
	sudo ln -s /etc/sv/libvirtd /var/service
	sudo ln -s /etc/sv/virtlockd /var/service
	sudo ln -s /etc/sv/virtlogd /var/service
}

configure_user () {
    printf "\nConfiguring user...\n"
    pactl set-sink-mute @DEFAULT_SINK@ toggle \
    	&& pactl -- set-sink-volume @DEFAULT_SINK@ 80%
	[ ! -d /run/user/"$(id -u)" ] \
		&& mkdir /run/user/"$(id -u)" \
		&& chmod 700 /run/user/"$(id -u)"
	eval "$(ssh-agent)"
	mkdir -p ~/.ssh \
		&& chmod 700 ~/.ssh \
		&& touch ~/.ssh/known_hosts \
		&& ssh-keyscan -t Ed25519 github.com > ~/.ssh/known_hosts
    [ -f /backup/.keys/qwertzy-antonio-godinho-github.com ] \
		&& ssh-add /backup/.keys/qwertzy-antonio-godinho-github.com
	sudo gpasswd -a "${USER_NAME}" wheel
	sudo gpasswd -a "${USER_NAME}" audio
	sudo gpasswd -a "${USER_NAME}" optical
	sudo gpasswd -a "${USER_NAME}" storage
	sudo gpasswd -a "${USER_NAME}" network
	sudo gpasswd -a "${USER_NAME}" libvirt
	sudo gpasswd -a "${USER_NAME}" bluetooth
	sudo gpasswd -a "${USER_NAME}" polkitd
}

main () {
	printf "\n${SCRIPT_NAME} - Automated System Setup\n"
	printf "\n/// IMPORTANT /// : This script should be used after a fresh voidlinux installation.
	            Use <CTRL>+C to abort the script executing anytime.\n\n"
	while true; do
		read -r -p "Do you wish to continue? " yn
		case $yn in
			[Yy]*) 
				check_previleges
				update_system
				enable_repos
				update_system
				install_packages
				configure_user
				copy_system_configuration
				disable_system_services
				enable_system_services
				printf "\n/// FINISHED ${SCRIPT_NAME} ///\n\n"
				while true; do
					read -r -p "Reboot the system? " yn
					case $yn in
						[Yy]*) 
							sudo reboot
						;;
						[Nn]*) 
							exit 0
						;;
						*) 
							echo "Use [Y/y] for 'Yes' or [N/n] for 'No'."
						;;
					esac
				done
			;;
			[Nn]*) 
				exit 0
			;;
			*) 
				echo "Use [Y/y] for 'Yes' or [N/n] for 'No'."
			;;
		esac
	done
}

main
