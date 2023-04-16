#! /usr/bin/env bash

WORK_DIRECTORY="${HOME}/.local/bin/vpn"
OVPN_SERVER_FILES="https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip"

main () {
	mkdir -p "$WORK_DIRECTORY"
	case $action in
		"--start")
			sudo openvpn --config "$WORK_DIRECTORY"/vpn.ovpn --auth-user-pass "$WORK_DIRECTORY"/auth.conf --auth-nocache --data-ciphers AES-256-CBC
			;;
		"--stop")
			if [ $(ps aux | grep -c "[o]penvpn") -gt 0 ] ; then
				sudo killall openvpn
			else
				printf "* OpenVPN process is not running...\n"
			fi
			;;
		"--refresh-servers")
			mkdir -p "$WORK_DIRECTORY"/ovpn
			wget "$OVPN_SERVER_FILES" -P "$WORK_DIRECTORY"
			unzip -j -o "$WORK_DIRECTORY"/ovpn.zip -d "$WORK_DIRECTORY"/ovpn
			rm -r --interactive=never "$WORK_DIRECTORY"/ovpn.zip
        ;;
        "--status")
        	if [ $(ps aux | grep -c "[o]penvpn") -gt 0 ]; then
				local pid=$(ps aux | grep "[o]penvpn" | awk '{print $2}')
				printf "* OpenVPN process is running with PID(s): \n$pid\n"
				else
				printf "* OpenVPN process is not running...\n"
        	fi
        ;;
        "--list-servers")
        	if [ -d "$WORK_DIRECTORY"/ovpn ]; then
        		ls "$WORK_DIRECTORY"/ovpn/ | less
        	else
        		printf "*** ERROR: - OVPN server files not found, use --refresh-servers. Exiting...\n"
exit 127
        	fi
        ;;
        "--set-server")
        	if [[ "$#" -gt 1 ]]; then
        		if [ -f "$WORK_DIRECTORY"/ovpn/"$server" ]; then
        			ln -sf "$(realpath "$WORK_DIRECTORY")/ovpn/$server" "$WORK_DIRECTORY"/vpn.ovpn
				else
					printf "*** ERROR: - Invalid server name, use --list-servers. Exiting...\n"
					exit 127
				fi
			else
				printf "*** ERROR: - Missing server name, use --list-servers, if necessary --refresh-servers. Exiting...\n" 
				exit 127
      		fi
        ;;
        "--show-server")
        	if [ -f "$WORK_DIRECTORY"/vpn.ovpn ]; then
        		stat "$WORK_DIRECTORY"/vpn.ovpn | head -1
        	else
				printf "*** ERROR: - A server hasn't been set, use --list-servers and then --set-server [SERVER_FILE_MAME]. Exiting...\n"
				exit 127
        	fi
        ;;
        *)
			printf "$0 - Option \"$action\" was not recognized...\n"
			printf "\n  * Work directory is set to $WORK_DIRECTORY\n"
			printf "\n  * Operations:\n"
			printf "    --start                         : Starts VPN\n"
			printf "    --stop                          : Stops VPN\n"
			printf "    --status                        : Get VPN process status\n"
			printf "\n  * VPN Operations:\n"
			printf "    --refresh-servers               : Downloads a new list of OVPN server files\n"
			printf "    --list-servers                  : Shows the list of available OVPN server files\n"
			printf "    --set-server [SERVER_FILE_NAME] : Sets the server to use for establishing VPN connections\n"
			printf "    --show-server                   : Shows the current set server\n\n"
			exit 127
        ;;
esac
}

action=$1
server=$2

main $action $server
