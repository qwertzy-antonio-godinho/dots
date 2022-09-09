#! /usr/bin/bash

msgId="34782933"

# check if process is running ( 0 = off, 1 = on )
STATUS="$(ps -ef | grep -w '[s]kippy' | wc -l)"
# if off then turn on
if [[ "${STATUS}" == 0 ]]; then
  [[ -z "$1" ]]
  skippy-xd --config ~/.config/skyppy-xd/skippy-xd.rc --start-daemon /dev/null 2>&1 & disown 
fi

# check if there are any windows available to show ( 0 = off, 1 = on )
STATUS="$(wmctrl -l | grep -v "conky" | grep icarus | wc -l)"
# if off then turn on
if [[ "${STATUS}" > 0 ]]; then
  [[ -z "$1" ]]
  skippy-xd --toggle-window-picker
fi
