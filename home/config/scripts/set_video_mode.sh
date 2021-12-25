#! /usr/bin/bash

TARGET_RESOLUTION=1024
MONITOR_REFRESH_RATE=144.00
TV_REFRESH_RATE=60


function set_scale () {
	local dpi=$1
	local dpi_xsettingsd=$2
	local mouse_size=$3
	local font_size=$4
	local ui_height=$5
	local ui_toolkit_scale=$6
	printf "\n       + DPI: ${dpi}"
	sed -i -E 's/Xft.dpi:.*/Xft.dpi: '$dpi'/' $HOME/.Xresources
	#printf "\n       + DPI (xsettingsd): ${dpi_xsettingsd}"
	#sed -i -E '/DPI/s/[0-9.]+/'$dpi_xsettingsd'/' $HOME/.xsettingsd 
	#local xsettingsd_status="$(ps -ef | grep -w '[x]settingsd' | wc -l)"
	#if [[ "${xsettingsd_status}" == 0 ]]; then
	#	xsettingsd > /dev/null 2>&1 & disown
	#elif [[ "${xsettingsd_status}" == 1 ]]; then
	#	killall -HUP xsettingsd
	#fi
	printf "\n       + Mouse cursor size: ${mouse_size}"
	sed -i -E 's/Xcursor.size:.*/Xcursor.size: '$mouse_size'/' $HOME/.Xresources
	printf "\n       + Font size: ${font_size}"
	sed -i -E 's/Liga mononoki-.[0-9]/Liga mononoki-'$font_size'/' $HOME/.fluxbox/styles/tron_blue/theme.cfg
	sed -i -E 's/liga Mononoki .[0-9]/liga Mononoki '$font_size'/' $HOME/.config/rofi/themes/tron.rasi
	printf "\n       + UI height: ${ui_height}"
	sed -i -E 's/toolbar.height: .[0-9]/toolbar.height: '$ui_height'/' $HOME/.fluxbox/styles/tron_blue/theme.cfg
	sed -i -E 's/window.title.height: .[0-9]/window.title.height: '$ui_height'/' $HOME/.fluxbox/styles/tron_blue/theme.cfg
	printf "\n       + UI toolkit scale: ${ui_toolkit_scale}"
	export GDK_SCALE=${ui_toolkit_scale}
	export QT_SCALE_FACTOR=${ui_toolkit_scale}
	printf "\n       + UI DPI scale: ${ui_dpi_scale}"
	export GDK_DPI_SCALE=${ui_dpi_scale}
	export QT_FONT_DPI=${dpi}
	export QT_AUTO_SCREEN_SET_FACTOR=0
}

function scale_ui () {
	local resolution="$1"
	printf "\n    -> Setting UI scale for ${resolution} ..."
	case $resolution in
		"1920x1080")
			local dpi=122
			local dpi_xsettingsd=$(($dpi * $TARGET_RESOLUTION))
			local mouse_size=32
			local font_size=10
			local ui_height=24
			local ui_toolkit_scale=1
			local ui_dpi_scale=0.5
		;;
		"3840x2160")
			local dpi=220
			local dpi_xsettingsd=$(($dpi * $TARGET_RESOLUTION))
			local mouse_size=64
			local font_size=20
			local ui_height=34
			local ui_toolkit_scale=2
			local ui_dpi_scale=0.5
		;;
		*)
			printf " ]\n[ ERROR ] no information how to handle resolution ${resolution}, exiting...\n"
			exit 127
		;;
	esac
	set_scale $dpi $dpi_xsettingsd $mouse_size $font_size $ui_height $ui_toolkit_scale
	printf "\n   "
}

function get_info () {
	PRIMARY_OUTPUT=$(xrandr | awk '/primary/ {print $1}')
}

function set_refresh_rate () {
	local output="$1"
	local resolution="$2"
	local primary="$3"
	# Monitor
	if [[ $output =~ DP-(.*) && $primary != "" ]]; then
		printf " @ ${MONITOR_REFRESH_RATE}"
		#te="xrandr --output $output $primary --mode $resolution --rate $MONITOR_REFRESH_RATE"
		#printf "\n$te\n"
		xrandr --output $output $primary --mode $resolution --rate $MONITOR_REFRESH_RATE
	# TV
	elif [[ $output =~ HDMI-(.*) && $primary != "" ]]; then
		printf " @ ${TV_REFRESH_RATE}"
		#xrandr --output $output $primary --mode $resolution --rate $TV_REFRESH_RATE
		nvidia-settings --assign CurrentMetaMode="HDMI-0: 1920x1080_${TV_REFRESH_RATE} +0+0 {viewportout=1840x1035+40+22} {ForceFullCompositionPipeline=On}"
	fi
}

function main () {
	local execute="$1"
	local machine_name=$(lscpu | grep 'Model name:' | cut -d\  -f3- | sed -e 's/^[ \t]*//')
	local available_outputs=($(xrandr | grep -w "connected" | awk '{print $1}'))
	get_info
	if [[ ! -z $execute || $execute != "--exec" ]]; then
		printf "INFO: Use '$0 --exec' to scale the UI\n"
	fi
	printf "* Computer: $machine_name\n"
	printf "* Available outputs:\n"
	if [[ ! -z $available_outputs && ! -z $machine_name ]]; then
		# Outputs > 1
		if [[ ${#available_outputs[@]} -gt 1 ]]; then
			for output in "${available_outputs[@]}"; do
				printf "  - ${output[@]} [ "
				# Output On
				if [[ $(xrandr | awk -v monitor="${output[@]} connected" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep "*" | wc -l) -gt 0 ]]; then
					local selected_resolution=$(xrandr | awk -v monitor="${output[@]} connected" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep "*" | awk '{ sub(/^[ \t]+/, ""); print $1}')
					printf "$selected_resolution"
					local is_primary=""
					# Is primary?
					if [[ $(xrandr | awk -v monitor="${output[@]}" '/connected/ {p = 0} $0 ~ monitor {p = 1} p'  | grep "primary" | wc -l) -gt 0 ]]; then
						printf " (PRIMARY)"
						is_primary="--primary"
					fi
					set_refresh_rate ${output[@]} $selected_resolution $is_primary
					if [[ $is_primary != "" ]]; then 
						if [[ $execute == "--exec" ]]; then
							scale_ui $selected_resolution
						fi
					else
						printf " --off"
						xrandr --output ${output[@]} --off
					fi
				# Output Off
				else
					printf "OFF"
				fi
				printf " ]\n"
			done
			exit 127
		# Outputs = 1
		elif [[ ${#available_outputs[@]} -eq 1 ]]; then
			local selected_resolution=$(xrandr | awk -v monitor="${output[@]} connected" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep "*" | awk '{ sub(/^[ \t]+/, ""); print $1}')
			printf "  - ${available_outputs[0]} [ $selected_resolution"
			set_refresh_rate ${available_outputs[0]} $selected_resolution
			if [[ $execute == "--exec" ]]; then
				scale_ui $selected_resolution
			fi
			printf " ]\n"
			exit 127
		# No Outputs
		else
			printf "[ ERROR ] Not able to find any Outputs, exiting...\n"
			exit 127
		fi
	else
		printf "[ ERROR ] Not able to identify hardware, exiting...\n"
		exit 127
	fi
}

main "$1"
