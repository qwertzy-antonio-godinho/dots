#! /bin/bash

trigger=$(date +%s --date="18:00:00")
theme_dark="W9-Dark"
theme_light="Victory"

if [ "$trigger" -lt "$(date +%s)" ]; then
	printf "Setting Dark theme...\n"
	sed -i -E "s/gtk-theme-name = .*/gtk-theme-name = $theme_dark/" "$HOME/.config/gtk-3.0/settings.ini"
else
	printf "Setting Light theme...\n"
	sed -i -E "s/gtk-theme-name = .*/gtk-theme-name = $theme_light/" "$HOME/.config/gtk-3.0/settings.ini"
fi
