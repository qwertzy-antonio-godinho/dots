#!/bin/bash

# History
export HISTIGNORE="&:ls:[bf]g:pwd:exit:cd .."
export HISTCONTROL="ignoreboth"
export HISTTIMEFORMAT="%Y/%m/%d %T "
export PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"

# Applications
export SHELL="/bin/bash"
export EDITOR="micro"
export BROWSER="brave"
export PAGER="less"
export GIT_EDITOR="${EDITOR}"
export USE_EDITOR="${EDITOR}"
export VISUAL="${EDITOR}"

# UI toolkit
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GDK_SCALE=1
export GDK_DPI_SCALE=1

# X session
export XDG_SESSION_TYPE="x11"
export XDG_CURRENT_DESKTOP="fluxbox"

# Extra
export ALERT="${RED}"
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
