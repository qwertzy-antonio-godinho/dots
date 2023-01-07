#! /usr/bin/env bash

export HISTCONTROL="erasedups:ignoredups"
export HISTSIZE=500000
export HISTFILESIZE=100000
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

export SHELL="/usr/bin/bash"
export EDITOR="micro"
export BROWSER="brave"
export PAGER="less"

export XDG_RUNTIME_DIR="${HOME}/.config/$(whoami)-$(id -u)"
export XDG_SESSION_TYPE="x11"
export XDG_CURRENT_DESKTOP="compiz"

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

export GIT_EDITOR="${EDITOR}"
export USE_EDITOR="${EDITOR}"
export VISUAL="${EDITOR}"

export ALERT="${RED}"
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export QT_QPA_PLATFORMTHEME="qt5ct"
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
