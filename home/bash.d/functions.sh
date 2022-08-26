# Show colors in manual pages
man () {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	command man "$@"
}

# Run SSH agent
__run_ssh_agent () {
	if ! pgrep -u "${USER}" ssh-agent > /dev/null; then
		ssh-agent -t 1h > "${XDG_RUNTIME_DIR}/ssh-agent.env"
	fi
	if [[ ! "${SSH_AUTH_SOCK}" ]]; then
		source "${XDG_RUNTIME_DIR}/ssh-agent.env" >/dev/null
	fi
}

# Applies dircolors
__apply_dircolors () {
	if command -v dircolors >/dev/null 2>&1; then
		[ -r "${HOME}/.dircolors" ] && eval "$(dircolors -b "${HOME}/.dircolors")" || eval "$(dircolors -b)"
	fi
}

# Runs Tmux
__run_tmux () {
	[ -z "${TMUX}" ] && { tmux attach || exec tmux new-session && exit;}
}

# Runs bash completion
__run_bash_completion () {
	[ -r /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
}

# Apply git bash prompt
__run_git_bash_prompt () {
	source /usr/share/git/completion/git-prompt.sh
	export GIT_PS1_SHOWSTASHSTATE=true
	export GIT_PS1_SHOWDIRTYSTATE=true
}

# Validate pyenv
__validate_pyenv () {
	export PYENV_ROOT="${HOME}/.pyenv"
	export PATH="${PATH}:${PYENV_ROOT}/bin"
	eval "$(pyenv init --path)"
}

# Validate Java
__validate_java () {
	export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
	export PATH="${PATH}:${JAVA_HOME}"
}