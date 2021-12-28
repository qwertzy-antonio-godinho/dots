#! /usr/bin/bash

function toogle_netwmpager () {
	local window_pid=$(xdotool search --all --name --class "netwmpager")
	local is_visible=$(xdotool search --onlyvisible --all --name --class "netwmpager" | wc -l)
	
	if [[ ${is_visible} -eq 0 ]]; then 
		xdotool windowmap --sync ${window_pid}
	elif [[ ${is_visible} -eq 1 ]]; then
		xdotool windowunmap --sync ${window_pid}
	fi
}

function main () {
	local status="$(ps -ef | grep -wc '[n]etwmpager')"
	
	if [[ "${status}" -eq 0 ]]; then
		netwmpager > /dev/null 2>&1 & disown
	elif [[ "${status}" -eq 1 ]]; then
		toogle_netwmpager
	fi
}

main 
