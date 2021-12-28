#! /usr/bin/bash

function toogle_skippy () {
	local available_windows=$(wmctrl -l | grep -v "conky" | grep -c "$(hostname)")
	
	if [[ ${available_windows} -gt 0 ]]; then 
		skippy-xd --toggle-window-picker
	fi
}

function main () {
	local status="$(ps -ef | grep -wc '[s]kippy')"
	
	if [[ "${status}" -eq 0 ]]; then
		skippy-xd --config ~/.config/skyppy-xd/skippy-xd.rc --start-daemon /dev/null 2>&1 & disown 
	elif [[ "${status}" -eq 1 ]]; then
		toogle_skippy
	fi
}

main 