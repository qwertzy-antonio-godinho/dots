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
	$(cat ~/.bash_history | fzf -i --exact)
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
		printf "${MAGENTA}${0} ${YELLOW}WARNING ${BLUE}__run_ssh_agent: ${NC}ssh-agent command not found\n"
	fi
}

__apply_dircolors () {
	if command -v dircolors >/dev/null 2>&1; then
		[ -r "${HOME}/.config/dircolors" ] && eval "$(dircolors -b "${HOME}/.config/dircolors")" || eval "$(dircolors -b)"
	else
		printf "${MAGENTA}${0} ${YELLOW}WARNING ${BLUE}__apply_dircolors: ${NC}dircolors command not found\n"
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
		printf "${MAGENTA}${0} ${YELLOW}WARNING ${BLUE}__run_git_bash_prompt: ${NC}git command not found\n"
	fi
}

__source_bash_completions () {
	local bash_completions_dir="/usr/share/bash-completion/completions/"
	local declare COMPLETIONS=(
		"git"
	)
	for completion_file in "${COMPLETIONS[@]}"; do
		local bash_completion="${bash_completions_dir}/${completion_file}"
		[ -f ${bash_completion} ] && source "${bash_completion}"
	done
}
