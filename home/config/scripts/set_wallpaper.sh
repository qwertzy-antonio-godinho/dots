#! /usr/bin/bash

WALLPAPER="/backup/Wallpapers/Wallpaper.jpg"

if [ -f "${WALLPAPER}" ]; then
	printf "Setting wallpaper: ${WALLPAPER}\n"
	hsetroot -cover "${WALLPAPER}"
else
	printf "Wallpaper: ${WALLPAPER} not found, skipping...\n"
fi
