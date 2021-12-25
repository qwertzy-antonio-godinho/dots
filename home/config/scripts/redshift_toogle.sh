#! /usr/bin/bash

msgId="34782931"

# check if process is running ( 0 = off, 1 = on )
STATUS="$(ps -ef | grep -w '[r]edshift' | wc -l)"
# if off then turn on
if [[ "${STATUS}" == 0 ]]; then
  [[ -z "$1" ]] && dunstify -r $msgId -a "redshift_toggle.sh" -u low "Redshift" "On"
  redshift > /dev/null 2>&1 & disown
# else if on then turn off
elif [[ "${STATUS}" == 1 ]]; then
  [[ -z "$1" ]] && dunstify -r $msgId -a "redshift_toggle.sh" -u low "Redshift" "Off"
  redshift -x && killall redshift
fi
