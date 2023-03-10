#! /usr/bin/env bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
BLUE=$(tput setaf 6)
WHITE=$(tput setaf 7)
GRAY=$(tput setaf 8)
NC=$(tput sgr0)

truecolor() {
	local i r g b
	for ((i = 0; i <= 79; i++)); do
		b=$((i*255/79))
		g=$((2*b))
		r=$((255-b))
		if [[ $g -gt 255 ]]; then
			g=$((2*255 - g))
		fi
		printf -- '\e[48;2;%d;%d;%dm \e[0m' "$r" "$g" "$b"
	done
	printf -- "\n"
}
