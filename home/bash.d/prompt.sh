#!/bin/bash

# ROOT user
if [ "$(id -u)" -eq 0 ]; then
	PS1='\[\033[01;33m\][ \h\[\033[00m\]: \[\033[01;34m\]\w\]\033[01;33m\] ]$(__git_ps1) \[\033[01;31m\]\u\033[00m\] \$ \n$(if [ $? -eq 0 ]; then printf "*"; else printf "ʭ"; fi) '
else
# Other users
	PS1='\[\033[01;33m\][ \h\[\033[00m\]: \[\033[01;34m\]\w\]\033[01;33m\] ]$(__git_ps1) \[\033[01;32m\]\u\033[00m\] \$ \n$(if [ $? -eq 0 ]; then printf "*"; else printf "ʭ"; fi) '
fi
