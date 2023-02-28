#! /bin/env bash

WALLPAPER="${HOME}/.config/wallpapers/wallpaper.jpg"

if [ -f "${WALLPAPER}" ]; then
	printf "Setting wallpaper ${WALLPAPER} ...\n"
	hsetroot -full "${WALLPAPER}"
fi
