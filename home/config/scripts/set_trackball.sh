#! /bin/bash

KEY_SCROLL="1"
KEY_MAPPING="10 2 11 4 5 6 7 8 9 1 3 12"

printf "*** ELECOM Trackball ***\n"
MOUSE_ID=$(xinput list --id-only "pointer:ELECOM TrackBall Mouse HUGE TrackBall")

if [ ! -z $MOUSE_ID ]; then
	printf "    ID: ${MOUSE_ID}\n"
	printf "[+] Scrolling button key: ${KEY_SCROLL}\n" 
	xinput set-prop "pointer:ELECOM TrackBall Mouse HUGE TrackBall" 'libinput Button Scrolling Button' 1
	xinput set-prop "pointer:ELECOM TrackBall Mouse HUGE TrackBall" 'libinput Scroll Method Enabled' 0 0 $KEY_SCROLL
	printf "[+] Button key mapping: ${KEY_MAPPING}\n"
	xinput set-button-map $MOUSE_ID $KEY_MAPPING
fi
