#! /usr/bin/env bash

__get_git_prompt_details () {
	if command -v git >/dev/null 2>&1; then
		local git_stash_size=$( (git stash list 2> /dev/null || :) | wc -l )
		printf "$(__git_ps1)"
		if [ $git_stash_size -gt 0 ]; then
			printf "+${git_stash_size}"
		fi
	fi
}

# ROOT user
if [ "$(id -u)" -eq 0 ]; then
	PS1='\[\033[01;33m\][ \h\[\033[00m\]: \[\033[01;34m\]\w\]\033[01;33m\] ]\[\033[01;36m\]$(__get_git_prompt_details) \[\033[01;31m\]\u\033[00m\] \$ \n$(if [ $? -eq 0 ]; then printf ">"; else printf "[!] >"; fi) '
else
# Other users
	PS1='\[\033[01;33m\][ \h\[\033[00m\]: \[\033[01;34m\]\w\]\033[01;33m\] ]\[\033[01;36m\]$(__get_git_prompt_details) \[\033[01;32m\]\u\033[00m\] \$ \n$(if [ $? -eq 0 ]; then printf ">"; else printf "[!] >"; fi) '
fi
