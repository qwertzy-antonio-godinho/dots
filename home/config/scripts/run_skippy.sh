#!/bin/bash

IS_RUNNING="$(pgrep skippy-xd)"

if [ "${IS_RUNNING}" -eq 0 ]; then
	skippy-xd --config ~/.config/skyppy-xd/skippy-xd.rc --start-daemon /dev/null 2>&1 & disown 
fi

HAS_WINDOWS="$(wmctrl -l | grep -v -E "conky|stalonetray" | grep -c "$(hostname)")"

if [ "${HAS_WINDOWS}" -gt 0 ]; then
	skippy-xd --toggle-window-picker
fi
