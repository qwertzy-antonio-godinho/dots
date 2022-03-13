#! /usr/bin/bash

# Settings
OUTPUT_TV="HDMI-0"
OUTPUT_TV_SET_REFRESH_RATE="60"
OUTPUT_TV_SET_RESOLUTION="1920x1080"

OUTPUT_MONITOR="DP-4"
OUTPUT_MONITOR_SET_REFRESH_RATE="144"
OUTPUT_MONITOR_SET_RESOLUTION="3440x1440"

# Temp
#OUTPUT_TV_STATE=""
#OUTPUT_MONITOR_STATE=""

function get_details () {
	local output_name="$1"
	local output_number="$2"
	local output_message=""; output_message="${output_name} :"

	if [[ $(xrandr | awk -v monitor="${output_name}" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep -c "\*") -gt 0 ]]; then

#		if [[ "${output_name}" == "${OUTPUT_TV}" ]]; then
#			OUTPUT_TV_STATE="ON"
#		elif [[ "${output_name}" == "${OUTPUT_MONITOR}" ]]; then
#			OUTPUT_MONITOR_STATE="ON"
#		fi

		output_message="${output_message} $(xrandr | awk -v monitor="${output_name}" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep "\*" | awk '{ sub(/^[ \t]+/, ""); print $1}')"
	else
		output_message="${output_message} Off"
	fi

	if [[ $(xrandr | awk -v monitor="${output_name}" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep -c "primary") -gt 0 ]]; then
		output_message="${output_message} Primary"
	fi

	printf "[ ${output_number} ] = %s\n" "${output_message}"
}

function print_detected_outputs () {
    printf "\nOutputs detected: %s\n\n" "${#available_outputs[@]}"
    for (( output_number=0; output_number<${#available_outputs[@]}; output_number++ )); do 
        get_details "${available_outputs[$output_number]}" "$((output_number + 1))"
    done
}

function set_primary () {
	local output_name="$1"
    printf "      - Setting %s as Primary output...\n" "${output_name}"
    xrandr --output "${output_name}" --primary
}

function enable_monitor () {
#	if [[ "${OUTPUT_MONITOR_STATE}" == "" ]]; then 
		printf "      - Turning On %s ${OUTPUT_MONITOR_SET_RESOLUTION} ${OUTPUT_MONITOR_SET_REFRESH_RATE}...\n" "${OUTPUT_MONITOR}"; 
#		2>/dev/null 1>&2 xrandr --output "${OUTPUT_MONITOR}" --scale 1.1x1.1; # Hack
#		xrandr --output "${OUTPUT_MONITOR}" --mode ${OUTPUT_MONITOR_SET_RESOLUTION} --rate ${OUTPUT_MONITOR_SET_REFRESH_RATE} --panning ${OUTPUT_MONITOR_SET_RESOLUTION} --scale 1x1; 
#	else 
		xrandr --output "${OUTPUT_MONITOR}" --mode ${OUTPUT_MONITOR_SET_RESOLUTION} --rate ${OUTPUT_MONITOR_SET_REFRESH_RATE}
#	fi
}

function enable_tv () {
#	if [[ "${OUTPUT_TV_STATE}" == "" ]]; then 
		printf "      - Turning On %s ${OUTPUT_TV_SET_RESOLUTION} ${OUTPUT_TV_SET_REFRESH_RATE}...\n" "${OUTPUT_TV}"; 
		2>/dev/null 1>&2 nvidia-settings --assign CurrentMetaMode="${OUTPUT_TV}: ${OUTPUT_TV_SET_RESOLUTION}_${OUTPUT_TV_SET_REFRESH_RATE} +0+0 {viewportout=1840x1035+40+22} {ForceFullCompositionPipeline=On}"; 
#	fi
}

function set_scale () {
	local dpi="$1"
	local mouse_size="$2"
	local font_size="$3"
	local ui_height="$4"
	local ui_toolkit_scale="$5"
	local ui_dpi_scale="$6"
	local output_name="$7"
	
	printf "        * DPI=%s\n" "$dpi"
	sed -i -E "s/Xft.dpi:.*/Xft.dpi: $dpi/" "$HOME/.Xresources"
	sed -i -E "s/-dpi.[0-9]*/-dpi $dpi/" "$HOME/.xbindkeysrc"
	#if [[ "${output_name}" == "${OUTPUT_MONITOR}" ]]; then xrandr --output "${output_name}" --scale 1x1; fi
	export QT_FONT_DPI=${dpi}
	
	printf "        * Mouse=%s\n" "$mouse_size"
	sed -i -E "s/Xcursor.size:.*/Xcursor.size: $mouse_size/" "$HOME/.Xresources"

	printf "        * Font=%s\n" "$font_size"
	sed -i -E "s/Liga mononoki-.[0-9]/Liga mononoki-$font_size/" "$HOME/.fluxbox/styles/lauzli/theme.cfg"
	sed -i -E "s/liga Mononoki .[0-9]/liga Mononoki $font_size/" "$HOME/.config/rofi/themes/lauzli.rasi"
	sed -i -E "s/faceSize: .[0-9]/faceSize: $font_size/" "$HOME/.Xresources"

	printf "        * UI=%s\n" "$ui_height"
	sed -i -E "s/.height: .[0-9]/.height: $ui_height/" "$HOME/.fluxbox/styles/lauzli/theme.cfg"

	printf "        * Toolkit=%s\n" "$ui_toolkit_scale"
	export GDK_SCALE=${ui_toolkit_scale}
	export QT_SCALE_FACTOR=${ui_toolkit_scale}

	printf "        * DPI scale=%s\n" "$ui_dpi_scale"
	export GDK_DPI_SCALE=${ui_dpi_scale}
	export QT_AUTO_SCREEN_SET_FACTOR=0
}

function set_resolution_scale () {
	local resolution="$1"
	local output="$2"
	printf "      - Scaling $output UI to %s resolution:\n" "${resolution}"

	case $resolution in
		"1920x1080")
			local scale_dpi=122
			local scale_mouse_size=32
			local scale_font_size=10
			local scale_ui_height=24
			local scale_ui_toolkit_scale=1
			local scale_ui_dpi_scale=0.5
		;;
		"3440x1440")
			local scale_dpi=142
			local scale_mouse_size=32
			local scale_font_size=11
			local scale_ui_height=28
			local scale_ui_toolkit_scale=1
			local scale_ui_dpi_scale=0.5
		;;
		*)
			printf " ]\n[ ERROR ] no information how to handle resolution %s, exiting...\n" "${resolution}"
			exit 127
		;;
	esac

	set_scale $scale_dpi $scale_mouse_size $scale_font_size $scale_ui_height $scale_ui_toolkit_scale $scale_ui_dpi_scale $output
}

function main () {
    local available_outputs=""; available_outputs=( $(xrandr | grep -w "connected" | awk '{print $1}') )
	if [[ ${#available_outputs[@]} -gt 0 ]]; then
        print_detected_outputs

		if [[ ${#available_outputs[@]} -eq 1 ]]; then
			set_primary "${available_outputs[0]}"

			if [[ "${available_outputs[0]}" == "${OUTPUT_MONITOR}" ]]; then
				enable_monitor
			elif [[ "${available_outputs[0]}" == "${OUTPUT_TV}" ]]; then
				enable_tv
			fi

			set_resolution_scale "$(xrandr | awk -v monitor="${available_outputs[0]}" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep "\*" | awk '{ sub(/^[ \t]+/, ""); print $1}')" "${available_outputs[0]}"
		fi

	else
		printf "[ INFO ] No outputs were detected, exiting...\n"
		exit 1
	fi
}

main "$1"
