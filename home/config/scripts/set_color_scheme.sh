#! /usr/bin/bash

DEFAULT_SCHEME=(
	"#3EBDFF"
	"#3EACE5"
	"#092A3B"
	"#0F4d6E"
	"#001f2f"
)

WALLPAPER="/backup/Wallpapers/Wallpaper.jpg"

readarray -t WALLPAPER_SCHEME < <(convert $WALLPAPER -scale 50x50! -depth 8 +dither -colors 8 -format "%c" histogram:info: | sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p' | sort -r -n -k 1 -t "," | awk -F',' '{print $2}' | head -5)

COLOR_SCHEME=("${WALLPAPER_SCHEME[@]}")

function set_TTY () {
	LOCATION="$HOME/.Xresources"
}

function set_Xresources () {
	LOCATION="$HOME/.Xresources"
}

function set_Fluxbox () {
	LOCATION="$HOME/.fluxbox/styles/tron_blue/theme.cfg"
	sed -i -E 's/rootCommand: fbsetroot -solid.*/rootCommand: fbsetroot -solid "'"${COLOR_SCHEME[0]}"'"/' "$LOCATION"
	sed -i -E 's/menu.borderColor:.*/menu.borderColor: '"${COLOR_SCHEME[2]}"'/' "$LOCATION"
	sed -i -E 's/menu.frame.textColor:.*/menu.frame.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"	
	sed -i -E 's/menu.frame.color:.*/menu.frame.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/menu.frame.colorTo:.*/menu.frame.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/menu.title.color:.*/menu.title.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/menu.title.colorTo:.*/menu.title.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/menu.title.textColor:.*/menu.title.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"	
	sed -i -E 's/menu.hilite.color:.*/menu.hilite.color: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"	
	sed -i -E 's/menu.hilite.colorTo:.*/menu.hilite.colorTo: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"	
	sed -i -E 's/menu.hilite.textColor:.*/menu.hilite.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.borderColor:.*/toolbar.borderColor: '"${COLOR_SCHEME[2]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.clock.textColor:.*/toolbar.clock.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.clock.color:.*/toolbar.clock.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.clock.colorTo:.*/toolbar.clock.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.workspace.color:.*/toolbar.workspace.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.workspace.colorTo:.*/toolbar.workspace.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.workspace.textColor:.*/toolbar.workspace.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.button.picColor:.*/toolbar.button.picColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.button.color:.*/toolbar.button.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.button.colorTo:.*/toolbar.button.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.button.pressed.picColor:.*/toolbar.button.pressed.picColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.button.pressed.color:.*/toolbar.button.pressed.color: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.button.pressed.colorTo:.*/toolbar.button.pressed.colorTo: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.label.textColor:.*/toolbar.label.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.label.color:.*/toolbar.label.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.label.colorTo:.*/toolbar.label.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.iconbar.color:.*/toolbar.iconbar.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.iconbar.colorTo:.*/toolbar.iconbar.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.iconbar.empty.color:.*/toolbar.iconbar.empty.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.iconbar.empty.colorTo:.*/toolbar.iconbar.empty.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.iconbar.focused.color:.*/toolbar.iconbar.focused.color: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"
	sed -i -E 's/toolbar.iconbar.focused.colorTo:.*/toolbar.iconbar.focused.colorTo: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.iconbar.focused.textColor:.*/toolbar.iconbar.focused.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.iconbar.unfocused.color:.*/toolbar.iconbar.unfocused.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.iconbar.unfocused.colorTo:.*/toolbar.iconbar.unfocused.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"	
	sed -i -E 's/toolbar.iconbar.unfocused.textColor:.*/toolbar.iconbar.unfocused.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"	
	sed -i -E 's/window.borderColor:.*/window.borderColor: '"${COLOR_SCHEME[2]}"'/' "$LOCATION"	
	sed -i -E 's/window.title.focus.colorTo:.*/window.title.focus.colorTo: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"
	sed -i -E 's/window.title.focus.color:.*/window.title.focus.color: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"
	sed -i -E 's/window.title.unfocus.colorTo:.*/window.title.unfocus.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.title.unfocus.color:.*/window.title.unfocus.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.label.focus.color:.*/window.label.focus.color: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"
	sed -i -E 's/window.label.focus.textColor:.*/window.label.focus.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/window.label.unfocus.color:.*/window.label.unfocus.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.label.unfocus.textColor:.*/window.label.unfocus.textColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/window.button.focus.color:.*/window.button.focus.color: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"      	
	sed -i -E 's/window.button.focus.colorTo:.*/window.button.focus.colorTo: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"      	
	sed -i -E 's/window.button.focus.picColor:.*/window.button.focus.picColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/window.button.unfocus.Color:.*/window.button.unfocus.Color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.button.unfocus.ColorTo:.*/window.button.unfocus.ColorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.button.unfocus.picColor:.*/window.button.unfocus.picColor: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/window.button.pressed.color:.*/window.button.pressed.color: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"
	sed -i -E 's/window.button.pressed.colorTo:.*/window.button.pressed.colorTo: '"${COLOR_SCHEME[3]}"'/' "$LOCATION"
	sed -i -E 's/window.frame.focusColor:.*/window.frame.focusColor: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.frame.unfocusColor:.*/window.frame.unfocusColor: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.handle.focus.color:.*/window.handle.focus.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.handle.focus.colorTo:.*/window.handle.focus.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.handle.unfocus.color:.*/window.handle.unfocus.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.handle.unfocus.colorTo:.*/window.handle.unfocus.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.grip.focus.color:.*/window.grip.focus.color: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/window.grip.focus.colorTo:.*/window.grip.focus.colorTo: '"${COLOR_SCHEME[1]}"'/' "$LOCATION"
	sed -i -E 's/window.grip.unfocus.color:.*/window.grip.unfocus.color: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
	sed -i -E 's/window.grip.unfocus.colorTo:.*/window.grip.unfocus.colorTo: '"${COLOR_SCHEME[4]}"'/' "$LOCATION"
}

function set_Conky1 () {
	LOCATION="$HOME/.config/conky/authnetrc"
	sed -i -E 's/default_color = .*/default_color = '"'${COLOR_SCHEME[0]}',"'/' "$LOCATION"
    sed -i -E 's/color1 = .*/color1 = '"'${COLOR_SCHEME[3]}',"'/' "$LOCATION"
    sed -i -E 's/color2 = .*/color2 = '"'${COLOR_SCHEME[4]}',"'/' "$LOCATION"
    sed -i -E 's/color3 = .*/color3 = '"'${COLOR_SCHEME[1]}',"'/' "$LOCATION"
}

function set_Conky2 () {
	LOCATION="$HOME/.config/conky/inforc"
}

function set_Dunst () {
	LOCATION="$HOME/.config/dunst/dunstrc"
}

function set_Alacritty () {
	LOCATION="$HOME/.config/alacritty/alacritty.yml"
}

function set_GTK () {
	LOCATION="$HOME/.config/"
}

function set_Qt () {
	LOCATION="$HOME/.config/"
}

function set_VisualStudio () {
	LOCATION="$HOME/.config/"
}

function set_PlumaGedit () {
	LOCATION="$HOME/.config/"
}

set_Conky1
