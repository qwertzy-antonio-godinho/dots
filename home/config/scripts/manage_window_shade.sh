#!/bin/bash

usage () {
	printf "${0} - ERROR : Option \"${action}\" was not recognized...\n"
	printf "\n * Operations:\n"
	printf "   --shade : Sets the shade property for all windows in the current workspace\n"
	printf "   --unshade : Removes the shade property for all windows in the current workspace\n"
	exit 127	
}

main () {
	local action="${1}"
	if [ ! -z "${action}" ]; then 
		local CURRENT_WINDOW=$(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2 | awk '{gsub("0x","0x0"); print $0}')
		local WORKSPACE=$(wmctrl -l | grep "${CURRENT_WINDOW}" | grep "$(hostname)" | awk '{print $2}')
		wmctrl -l | while read -r i; do 
			local WINDOW_WORKSPACE=$(printf "${i}" | awk '{print $2}')  
			if [ "${WINDOW_WORKSPACE}" = "${WORKSPACE}" ]; then
		    	local WINDOW=$(printf "${i}" | awk '{print $1}')
				if [ "${action}" == "--shade" ]; then
					wmctrl -i -r "${WINDOW}" -b add,shaded
				elif [ "${action}" == "--unshade" ]; then
					wmctrl -i -r "${WINDOW}" -b remove,shaded
				elif [ "${action}" == "--shade-others" ]; then
					if [ ! "${WINDOW}" == "${CURRENT_WINDOW}" ]; then
						wmctrl -i -r "${WINDOW}" -b add,shaded
					fi
				else
					usage "${action}"
				fi
			fi 
		done				
	else
		usage
	fi
}

action="${1}"
main "${action}"
