#! /usr/bin/bash

# Settings
OUTPUT_TV="HDMI-0"
OUTPUT_TV_SET_REFRESH_RATE="60"
OUTPUT_TV_SET_RESOLUTION="1920x1080"

OUTPUT_MONITOR="DP-4"
OUTPUT_MONITOR_SET_REFRESH_RATE="144"
OUTPUT_MONITOR_SET_RESOLUTION="3440x1440"

# Temp
OUTPUT_TV_STATE=""
OUTPUT_TV_IS_PRIMARY=""

OUTPUT_MONITOR_STATE=""
OUTPUT_MONITOR_IS_PRIMARY=""

function get_details () {
	local output_name="$1"
	local output_number="$2"
	local output_message=""; output_message="${output_name} :"

	if [[ $(xrandr | awk -v monitor="${output_name}" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep -c "\*") -gt 0 ]]; then

		if [[ "${output_name}" == "${OUTPUT_TV}" ]]; then
			OUTPUT_TV_STATE="ON"
		elif [[ "${output_name}" == "${OUTPUT_MONITOR}" ]]; then
			OUTPUT_MONITOR_STATE="ON"
		fi

		output_message="${output_message} $(xrandr | awk -v monitor="${output_name}" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep "\*" | awk '{ sub(/^[ \t]+/, ""); print $1}')"
	else
		output_message="${output_message} Off"
	fi

	if [[ $(xrandr | awk -v monitor="${output_name}" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep -c "primary") -gt 0 ]]; then

		if [[ "${output_name}" == "${OUTPUT_TV}" ]]; then
			OUTPUT_TV_IS_PRIMARY="PRIMARY"
		elif [[ "${output_name}" == "${OUTPUT_MONITOR}" ]]; then
			OUTPUT_MONITOR_IS_PRIMARY="PRIMARY"
		fi

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

function main () {
    local available_outputs=""; available_outputs=( $(xrandr | grep -w "connected" | awk '{print $1}') )
	if [[ ${#available_outputs[@]} -gt 0 ]]; then
        print_detected_outputs

		if [[ ${#available_outputs[@]} -eq 1 ]]; then

			if [[ "${available_outputs[0]}" == "${OUTPUT_MONITOR}" ]]; then

				if [[ "${OUTPUT_MONITOR_IS_PRIMARY}" == "" ]]; then set_primary ${OUTPUT_MONITOR}; fi
				
                if [[ "${OUTPUT_MONITOR_STATE}" == "" ]]; then 
					printf "      - Turning On %s ${OUTPUT_MONITOR_SET_RESOLUTION} ${OUTPUT_MONITOR_SET_REFRESH_RATE}...\n" "${OUTPUT_MONITOR}"; 
					2>/dev/null 1>&2 xrandr --output "${OUTPUT_MONITOR}" --scale 1.1x1.1; # Hack
					xrandr --output "${OUTPUT_MONITOR}" --mode ${OUTPUT_MONITOR_SET_RESOLUTION} --rate ${OUTPUT_MONITOR_SET_REFRESH_RATE} --panning ${OUTPUT_MONITOR_SET_RESOLUTION} --scale 1x1; 
				else 
                    xrandr --output "${OUTPUT_MONITOR}" --mode ${OUTPUT_MONITOR_SET_RESOLUTION} --rate ${OUTPUT_MONITOR_SET_REFRESH_RATE}
                fi

			elif [[ "${available_outputs[0]}" == "${OUTPUT_TV}" ]]; then

				if [[ "${OUTPUT_TV_IS_PRIMARY}" == "" ]]; then set_primary ${OUTPUT_TV}; fi
				
                if [[ "${OUTPUT_TV_STATE}" == "" ]]; then 
					printf "      - Turning On %s ${OUTPUT_TV_SET_RESOLUTION} ${OUTPUT_TV_SET_REFRESH_RATE}...\n" "${OUTPUT_TV}"; 
					2>/dev/null 1>&2 nvidia-settings --assign CurrentMetaMode="${OUTPUT_TV}: ${OUTPUT_TV_SET_RESOLUTION}_${OUTPUT_TV_SET_REFRESH_RATE} +0+0 {viewportout=1840x1035+40+22} {ForceFullCompositionPipeline=On}"; 
				fi

			fi

		fi

	else
		printf "[ INFO ] No outputs were detected, exiting...\n"
		exit 1
	fi
}

main "$1"