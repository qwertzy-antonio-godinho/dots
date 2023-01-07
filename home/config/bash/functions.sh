#! /usr/bin/env bash

man () {
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	command man "$@"
}

hist () {
	if command -v fzf >/dev/null 2>&1; then
		$(cat ~/.bash_history | fzf -i --exact)
	else
		printfl E "${RED}($BASH_SOURCE:hist) ${NC}fzf command not found\n"
	fi
}

printfl () {
	local message_type="$1"
	local message="$2"
	case "$message_type" in
		"A") # Action
			printf "${MAGENTA}[ # ] "
		;;
		"W") # Warning
			printf "${YELLOW}[ * ] "
		;;
		"I") # Info
			printf "${GREEN}[ + ] "
		;;
		"E") # Error
			printf "${RED}[ ! ] "
		;;
		*)
			printf "${GRAY}[ - ] "
		;;
	esac
	printf "${GRAY}$(date +"%Y/%m/%d %H:%M:%S") ${BLUE}Message: ${YELLOW}${message}${NC}"
}

__run_ssh_agent () {
	if command -v ssh-agent >/dev/null 2>&1; then
		if ! pgrep -u "${USER}" ssh-agent > /dev/null; then
			ssh-agent -t 1h > "${XDG_RUNTIME_DIR}/ssh-agent.env"
		fi
		if [[ ! "${SSH_AUTH_SOCK}" ]]; then
			source "${XDG_RUNTIME_DIR}/ssh-agent.env" >/dev/null
		fi
	else
		printfl E "${RED}($BASH_SOURCE:__run_ssh_agent) ${NC}ssh-agent command not found\n"
	fi
}

__enable_tmux () {
	if command -v tmux >/dev/null 2>&1; then
		[ -z "${TMUX}" ] && { tmux attach || exec tmux new-session && exit; }
	else
		printfl E "${RED}($BASH_SOURCE:__enable_tmux) ${NC}tmux command not found\n"
	fi
}

__apply_dircolors () {
	if command -v dircolors >/dev/null 2>&1; then
		[ -r "${HOME}/.config/dircolors" ] && eval "$(dircolors -b "${HOME}/.config/dircolors")" || eval "$(dircolors -b)"
	else
		printfl E "${RED}($BASH_SOURCE:__apply_dircolors) ${NC}dircolors command not found\n"
	fi
}

__get_git_bash_prompt () {
	if command -v git >/dev/null 2>&1; then
		source /usr/share/git/git-prompt.sh
		export GIT_PS1_SHOWSTASHSTATE=true
		export GIT_PS1_SHOWDIRTYSTATE=true
		export GIT_PS1_SHOWUPSTREAM=auto
		export GIT_PS1_SHOWUNTRACKEDFILES=true
		export GIT_PS1_SHOWCONFLICTSTATE=yes
		export GIT_PS1_SHOWCOLORHINTS=true
	else
		printfl E "${RED}($BASH_SOURCE:__get_git_bash_prompt) ${NC}git command not found\n"
	fi
}

__source_bash_completions () {
	local bash_completions_dir="/usr/share/bash-completion/completions"
	if [ -d "$bash_completions_dir" ]; then
		local declare COMPLETIONS=(
			"git"
		)
		for completion_file in "${COMPLETIONS[@]}"; do
			local bash_completion="${bash_completions_dir}/${completion_file}"
			[ -f ${bash_completion} ] && source "${bash_completion}"
		done
	else
		printfl E "${RED}($BASH_SOURCE:__source_bash_completions) ${NC}${bash_completions_dir} directory not found\n"
	fi
}
