#! /usr/bin/env bash

search=$(printf '%s' "$*" | tr ' ' '+')
mpv "https://youtube.com/$(curl -s "https://vid.puffyan.us/search?q=$search" | grep -Eo "watch\?v=.{11}" | head -n 1 )"