#! /usr/bin/bash

DOTS_HOME_SOURCE="$(pwd)/home"
DOTS_HOME_TARGET="$HOME"

function create_directories () {
    find "$DOTS_HOME_SOURCE" -type d -printf '%P\n' | while read -r directory; 
    do
        mkdir -v -p "$DOTS_HOME_TARGET/.$directory"
    done
}

function update_source () {
    cp -v -f -p "$DOTS_HOME_TARGET/.$dot" "$DOTS_HOME_SOURCE/$dot"
}

function update_target () {
    if [[ -L "$DOTS_HOME_SOURCE/$dot" ]]; then
        cp -v -f -p -r "$DOTS_HOME_SOURCE/$dot" "$DOTS_HOME_TARGET/.$dot"
    else
        ln -s -v -f -r "$DOTS_HOME_SOURCE/$dot" "$DOTS_HOME_TARGET/.$dot"
    fi
}

function remove_dead_links () {
    find "$DOTS_HOME_SOURCE" -type l ! -exec test -e {} \; -exec rm {} \;
}

function main () {
    local dry_run="$1"
    if [[ "$dry_run" == "--no-dry-run" || "$dry_run" == "--no-dry-run-update-source" || "$dry_run" == "--no-dry-run-update-target" ]]; then remove_dead_links; create_directories; else printf "***\nExecuting in Dry Run mode, no changes will be made\nUse --no-dry-run to apply updates to source and target locations\nUse --no-dry-run-update-target to apply updates to target locations\nUse --no-dry-run-update-source to apply updates to source locations\n***\n"; fi
    find "$DOTS_HOME_SOURCE" -name '*' -type f,l -printf '%P\n' | while read -r dot; do
        if [[ ! -f "$DOTS_HOME_TARGET/.$dot" ]]; then
            if [[ "$dry_run" != "--no-dry-run-update-source" ]]; then printf "[ UPD-TARGET : $DOTS_HOME_TARGET ] %s\n" "$dot"; fi
            if [[ "$dry_run" == "--no-dry-run" || "$dry_run" == "--no-dry-run-update-target" ]]; then update_target; fi
        else
            if [[ $(date +%s -r "$DOTS_HOME_TARGET/.$dot") -lt $(date +%s -r "$DOTS_HOME_SOURCE/$dot") ]]; then
                if [[ "$dry_run" != "--no-dry-run-update-source" ]]; then printf "[ UPD-TARGET : $DOTS_HOME_TARGET ] %s\n" "$dot"; fi
                if [[ "$dry_run" == "--no-dry-run" || "$dry_run" == "--no-dry-run-update-target" ]]; then update_target; fi
            fi
            if [[ $(date +%s -r "$DOTS_HOME_TARGET/.$dot") -gt $(date +%s -r "$DOTS_HOME_SOURCE/$dot") ]]; then
                if [[ "$dry_run" != "--no-dry-run-update-target" ]]; then printf "[ UPD-SOURCE : $DOTS_HOME_SOURCE ] %s\n" "$dot"; fi
                if [[ "$dry_run" == "--no-dry-run" || "$dry_run" == "--no-dry-run-update-source" ]]; then update_source; fi
            fi
        fi
    done
}

main "$1"
