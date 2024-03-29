#!/bin/bash

alias ls="ls -CF --color=auto"
alias df="df -h --total"
alias mkdir="mkdir -pv"
alias free="free -mt"
alias wget="wget -c"
alias myip="curl ipv4.icanhazip.com"
alias grep="grep --color=auto"
alias less="less -iFMRSX -x4"
alias ncdu="ncdu --color=dark"
alias diff="diff --color=auto"
alias ip="ip -c"
alias cat="bat"
alias tree="tree -C"
alias most="most -w"
alias git-status="git status -sb --show-stash --ahead-behind"
alias git-commit-dry="git commit --dry-run --short --branch"
alias git-log="git log --graph --pretty=format:'%Cred%h%Creset %ad %s%C(yellow) %d%Creset %C(bold blue)<%an>%Creset' --date=short"
alias xterm="xterm -j -s"

# TV output
alias tv-small="nvidia-settings --assign CurrentMetaMode='HDMI-0: 1920x1080_60 +0+0 {viewportout=1840x1035+40+22} {ForceFullCompositionPipeline=On}'"
alias tv-big="nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}'"