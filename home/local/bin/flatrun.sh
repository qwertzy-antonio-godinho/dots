#! /usr/bin/env bash

readarray -t APPS < <(flatpak list --app --columns=name)
readarray -t COMMANDS < <(flatpak list --app --columns=application)
RADIO_STATE=()
ROWS=()

for (( i = 0; i < "${#APPS[@]}"; ++i )); do
    ROWS+=("${RADIO_STATE[i]}" "${APPS[i]}" "${COMMANDS[i]}")
done

while :
do
    RUN=$(
        zenity \
        --list --radiolist \
        --title="Flatpak applications" --text="Select application to run from list:" \
        --column="" --column="Application" --column="Command" \
        --width=440 \
        --height=600 \
        --print-column=3 \
        "${ROWS[@]}"
    )
    if [ "$?" -eq 1 ]; then
        exit 1
    else
        if [ -z "${RUN}" ]; then
            printf "ERROR : Please select an application to run.\n"
            exit 1
        else
            execute="flatpak run ${RUN}"
            eval "${execute}"
        fi
    fi
done