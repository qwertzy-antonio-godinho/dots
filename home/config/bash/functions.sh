#! /usr/bin/env bash

git_switch () {
	git checkout \
		$( \
			git branch -a -vv --color=always | \
			grep -v '/HEAD\s' | \
			fzf --ansi --multi --tac | \
			sed 's/^..//' | \
			awk '{print $1}' | \
			sed 's#^remotes/[^/]*/##' \
		)
}

git_add () {
	git add \
		$( \
			git -c color.status=always status --short | \
			fzf -m --ansi --nth 2..,.. | \
			awk '{print $2}' \
		)
}

git_diff ()
{
	PREVIEW_PAGER="delta"
	ENTER_PAGER=${PREVIEW_PAGER}
	if [ -x "$(command -v diff-so-fancy)" ]; then
		PREVIEW_PAGER="diff-so-fancy | ${PREVIEW_PAGER}"
		ENTER_PAGER="diff-so-fancy | sed -e '1,4d' | ${ENTER_PAGER}"
	fi

	# Don't just diff the selected file alone, get related files first using
	# '--name-status -R' in order to include moves and renames in the diff.
	# See for reference: https://stackoverflow.com/q/71268388/3018229
	PREVIEW_COMMAND='git diff --color=always '$@' -- \
		$(echo $(git diff --name-status -R '$@' | grep {}) | cut -d" " -f 2-) \
		| '$PREVIEW_PAGER

	# Show additional context compared to preview
	ENTER_COMMAND='git diff --color=always '$@' -U10000 -- \
		$(echo $(git diff --name-status -R '$@' | grep {}) | cut -d" " -f 2-) \
		| '$ENTER_PAGER

	git diff --name-only $@ | \
		fzf ${GIT_FZF_DEFAULT_OPTS} --exit-0 --preview "${PREVIEW_COMMAND}" \
		--preview-window 'right,70%,border-left' --bind "enter:execute:${ENTER_COMMAND}"
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

gstash() {
  local out k reflog
  out=(
    $(git stash list --pretty='%C(yellow)%gd %>(14)%Cgreen%cr %C(blue)%gs' |
      fzf --ansi --no-sort --header='enter:show, ctrl-d:diff, ctrl-o:pop, ctrl-y:apply, ctrl-x:drop' \
          --preview='git stash show --color=always -p $(cut -d" " -f1 <<< {}) | head -'$LINES \
          --preview-window=down:50% --reverse \
          --bind='enter:execute(git stash show --color=always -p $(cut -d" " -f1 <<< {}) | less -r > /dev/tty)' \
          --bind='ctrl-d:execute(git diff --color=always $(cut -d" " -f1 <<< {}) | less -r > /dev/tty)' \
          --expect=ctrl-o,ctrl-y,ctrl-x))
  k=${out[0]}
  reflog=${out[1]}
  [ -n "$reflog" ] && case "$k" in
    ctrl-o) git stash pop $reflog ;;
    ctrl-y) git stash apply $reflog ;;
    ctrl-x) git stash drop $reflog ;;
  esac
}

git_log ()
{
	PREVIEW_COMMAND='f() {
		set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}")
		[ $# -eq 0 ] || (
			git show --no-patch --color=always $1
			echo
			git show --stat --format="" --color=always $1 |
			while read line; do
				tput dim
				echo " $line" | sed "s/\x1B\[m/\x1B\[2m/g"
				tput sgr0
			done |
			tac | sed "1 a \ " | tac
		)
	}; f {}'

	ENTER_COMMAND='(grep -o "[a-f0-9]\{7\}" | head -1 |
		xargs -I % bash -ic "git_log %^1 %") <<- "FZF-EOF"
		{}
		FZF-EOF'

	git log --graph --color=never --format="%C(auto)%h %s%d " | \
		fzf ${GIT_FZF_DEFAULT_OPTS} --no-sort --tiebreak=index \
		--preview "${PREVIEW_COMMAND}" --preview-window=top:15 \
		--bind "enter:execute:${ENTER_COMMAND}"
}

man () {
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	command man "${@}"
}

hist () {
	if command -v fzf >/dev/null 2>&1; then
		eval "$(fzf -i --exact < "${HOME}/.bash_history")"
	else
		printfl E "${RED}(${BASH_SOURCE}:hist) ${NC}fzf command not found\n"
	fi
}

mediav () {
	timg \
		"$(find . -path '*/.git/*' -prune -o -printf '%P\n' 2>/dev/null | fzf \
			--exact \
			--no-separator \
			--preview='timg --title=%D -g${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES} --frames=1 {}' \
			--bind shift-up:preview-page-up,shift-down:preview-page-down \
			--preview-window 'right,60%,border-left' \
		)" \
	-V
}

printfl () {
	local message_type="${1}"
	local message="${2}"
	case "${message_type}" in
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
		if [ -n "${SSH_AUTH_SOCK}" ]; then
			source "${XDG_RUNTIME_DIR}/ssh-agent.env" >/dev/null
		fi
	else
		printfl E "${RED}(${BASH_SOURCE}:__run_ssh_agent) ${NC}ssh-agent command not found\n"
	fi
}

__apply_dircolors () {
	if command -v dircolors >/dev/null 2>&1; then
		[ -r "${HOME}/.config/dircolors" ] \
			&& eval "$(dircolors -b "${HOME}/.config/dircolors")" || eval "$(dircolors -b)"
	else
		printfl E "${RED}(${BASH_SOURCE}:__apply_dircolors) ${NC}dircolors command not found\n"
	fi
}

__get_git_bash_prompt () {
	if command -v git >/dev/null 2>&1; then
		source /usr/share/git/git-prompt.sh \
			&& export GIT_PS1_SHOWSTASHSTATE=true \
			&& export GIT_PS1_SHOWDIRTYSTATE=true \
			&& export GIT_PS1_SHOWUPSTREAM=auto \
			&& export GIT_PS1_SHOWUNTRACKEDFILES=true \
			&& export GIT_PS1_SHOWCONFLICTSTATE=yes \
			&& export GIT_PS1_SHOWCOLORHINTS=true
	else
		printfl E "${RED}(${BASH_SOURCE}:__get_git_bash_prompt) ${NC}git command not found\n"
	fi
}

__source_bash_completions () {
	local bash_completions_dir="/usr/share/bash-completion/completions"
	if [ -d "${bash_completions_dir}" ]; then
		declare -a COMPLETIONS=(
			"git"
			"docker"
			"mount"
			"umount"
		)
		for completion_file in "${COMPLETIONS[@]}"; do
			local bash_completion="${bash_completions_dir}/${completion_file}"
			[ -f "${bash_completion}" ] \
				&& source "${bash_completion}"
		done
	else
		printfl E "${RED}(${BASH_SOURCE}:__source_bash_completions) ${NC}${bash_completions_dir} directory not found\n"
	fi
}

__async_run() {
  {
    eval "$@" &> /dev/null
  }& disown -h
}
