#!/bin/bash

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

# Applies dircolors
__apply_dircolors () {
	if command -v dircolors >/dev/null 2>&1; then
		[ -r "${HOME}/.dircolors" ] && eval "$(dircolors -b "${HOME}/.dircolors")" || eval "$(dircolors -b)"
	else
		printf "${MAGENTA}${0} ${YELLOW}WARNING ${BLUE}__apply_dircolors: ${NC}dircolors command not found\n"
	fi
}

# Runs Tmux
__run_tmux () {
	if command -v tmux >/dev/null 2>&1; then
		[ -z "${TMUX}" ] && { tmux attach || exec tmux new-session && exit;}
	else
		printf "${MAGENTA}${0} ${YELLOW}WARNING ${BLUE}__runs_tmux: ${NC}tmux command not found\n"
	fi
}

# Runs bash completion
__run_bash_completion () {
	[ -r /usr/share/bash-completion/bash_completion ] \
		&& source /usr/share/bash-completion/bash_completion \
		|| printf "${MAGENTA}${0} ${YELLOW}WARNING ${BLUE}__run_bash_completion: ${NC}bash_completion was not found\n"
}

# Apply git bash prompt
__run_git_bash_prompt () {
	if command -v git >/dev/null 2>&1; then
		source /usr/share/git/completion/git-prompt.sh
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

# Validate pyenv
__validate_pyenv () {
	if command -v pyenv >/dev/null 2>&1; then
		export PYENV_ROOT="${HOME}/.pyenv"
		export PATH="${PATH}:${PYENV_ROOT}/bin"
		eval "$(pyenv init --path)"
	else
		printf "${MAGENTA}${0} ${YELLOW}WARNING ${BLUE}__validate_pyenv: ${NC}pyenv command not found\n"
	fi
}

# Validate Java
__validate_java () {
	#export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
	export JAVA_HOME="/workbench/java/jdk-18.0.2.1"
	export JAVA_BIN="${JAVA_HOME}/bin"
	if [ -f "${JAVA_BIN}/java" ]; then
		export PATH="${PATH}:${JAVA_HOME}"
		export PATH="${PATH}:${JAVA_BIN}"
		export PATH="/workbench/java/apache-maven-3.8.6/bin:${PATH}"
	else
		printf "${MAGENTA}${0} ${YELLOW}WARNING ${BLUE}__validate_java: ${NC}JAVA_HOME is not properly configured\n"
	fi
}
