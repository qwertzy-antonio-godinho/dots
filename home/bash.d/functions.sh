# Show colorized manual pages
function man () {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	command man "$@"
}

# Get python virtual environment information
function get_virtualenv_info () {
    [ $VIRTUAL_ENV ] && echo ''`basename $VIRTUAL_ENV`' '
}

# Run SSH agent
function run_ssh_agent () {
	if ! pgrep -u "$USER" ssh-agent > /dev/null; then
		ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
	fi
	if [[ ! "$SSH_AUTH_SOCK" ]]; then
		source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
	fi
}

# Applies dircolors
function apply_dircolors () {
	if command -v dircolors >/dev/null 2>&1; then
		test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	fi
}

# Runs tmux
function run_tmux () {
	[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
}

# Runs bash completion
function run_bash_completion () {
	[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
}

# Apply git bash prompt
function run_git_bash_prompt () {
	source /usr/share/git/completion/git-prompt.sh
	GIT_PS1_SHOWSTASHSTATE=true
	GIT_PS1_SHOWDIRTYSTATE=true
}

# Validate pyenv
function validate_pyenv () {
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="${PATH}:${PYENV_ROOT}/bin"
	eval "$(pyenv init --path)"
}

# Validate Java
function validate_java () {
	export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
	export PATH="${PATH}:${JAVA_HOME}"
}
