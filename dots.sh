#! /usr/bin/env bash

DOTS_SOURCE="$(dirname "${0}")/home"
DOTS_TARGET="${HOME}"

create_directories () {
    find "${DOTS_SOURCE}" -type d -printf '%P\n' | while read -r directory; 
    do
        mkdir -v -p "${DOTS_TARGET}/.${directory}"
    done
}

update_source () {
    cp -v -f -p "${DOTS_TARGET}/.${dot}" "${DOTS_SOURCE}/${dot}"
}

update_target () {
    if [ -L "${DOTS_SOURCE}/${dot}" ]; then
        cp -v -f -p -r "${DOTS_SOURCE}/${dot}" "${DOTS_TARGET}/.${dot}"
    else
	    ln -s -v -f -r "${DOTS_SOURCE}/${dot}" "${DOTS_TARGET}/.${dot}"
    fi
}

remove_dead_links () {
    find "${DOTS_SOURCE}" -type l ! -exec test -e {} \; -exec rm {} \;
}

main () {
    local dry_run="${1}"
    if [ "${dry_run}" == "--no-dry-run" ]; then 
        remove_dead_links \
            && create_directories
    else 
        printf "***\nExecuting in Dry Run mode, no changes will be made\nUse --no-dry-run to apply updates to source and target locations\n***\n"
    fi
    find "${DOTS_SOURCE}" -name '*' -type f,l -printf '%P\n' | while read -r dot; do
        if [ ! -f "${DOTS_TARGET}/.${dot}" ]; then
            printf "[ File was not found -> UPDATE-TARGET : ${DOTS_TARGET} ] ./%s\n" "${dot}"
            if [ "${dry_run}" == "--no-dry-run" ]; then update_target; fi
        else
            if [ $(date +%s -r "${DOTS_TARGET}/.$dot") -lt $(date +%s -r "${DOTS_SOURCE}/$dot") ]; then
                printf "[ Date target older -> UPDATE-TARGET : ${DOTS_TARGET} ] ./%s\n" "${dot}"
                if [ "${dry_run}" == "--no-dry-run" ]; then update_target; fi
            fi
            if [ $(date +%s -r "${DOTS_TARGET}/.$dot") -gt $(date +%s -r "${DOTS_SOURCE}/$dot") ]; then
                printf "[ Date target newer -> UPDATE-SOURCE : ${DOTS_SOURCE} ] %s\n" "${dot}"
                if [ "${dry_run}" == "--no-dry-run" ]; then update_source; fi
            fi
        fi
    done
}

main "${1}"
