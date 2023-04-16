#! /usr/bin/env bash

WINBIN="/backup/Games/winbin"
WINERUNTIME="${WINBIN}/runtime"
WINEPREFIXES="${WINBIN}/prefixes"
WINETRICKS="${WINBIN}/winetricks"

# 32 Bits
WINE32="${WINBIN}/wine32"
WINEDLLPATH32="${WINBIN}/lib32"
WINESERVER32="${WINBIN}/wineserver32"
WINERUNTIME32="${WINERUNTIME}/32bits"

# 64 Bits
WINE64="${WINBIN}/wine64"
WINEDLLPATH64="${WINBIN}/lib64"
WINESERVER64="${WINBIN}/wineserver64"
WINERUNTIME64="${WINERUNTIME}/64bits"

setup () {
	# 32 Bits
	runtime32=$(find "${WINERUNTIME32}" -maxdepth 1 -mindepth 1 -type d | fzf --prompt "Select 32 Bits runtime > ")
	if [ ! -z "${runtime32}" ]; then
		ln -sf "${runtime32}/bin/wine" "${WINE32}"
		ln -sf "${runtime32}/bin/wineserver" "${WINESERVER32}"
		if [ -d "${WINEDLLPATH32}" ]; then
			rm -rf "${WINEDLLPATH32}"
		fi
		ln -s "${runtime32}/lib" "${WINEDLLPATH32}"
	else
		printf "ERROR : Missing 32 Bits runtime, use --download-runtime\n"
		exit 1
	fi
	# 64 Bits
	runtime64=$(find "${WINERUNTIME64}" -maxdepth 1 -mindepth 1 -type d | fzf --prompt "Select 64 Bits runtime > ")
	if [ ! -z "${runtime64}" ]; then
		ln -sf "${runtime64}/bin/wine" "${WINE64}"
		ln -sf "${runtime64}/bin/wineserver" "${WINESERVER64}"
		if [ -d "${WINEDLLPATH64}" ]; then
			rm -rf "${WINEDLLPATH64}"
		fi
		ln -s "${runtime64}/lib" "${WINEDLLPATH64}"
	else
		printf "ERROR : Missing 64 Bits runtime, use --download-runtime\n"
		exit 1		
	fi
}

show_config () {
	symlinks=("${WINE32}" "${WINE64}" "${WINEDLLPATH32}" "${WINEDLLPATH64}" "${WINESERVER32}" "${WINESERVER64}")
	for symlink in "${symlinks[@]}"; do
		if [ -e "${symlink}" ]; then
			ls -la "${symlink}" | awk '{ print $9, "---> " $NF }'
		else
			printf "ERROR : Symlink ${symlink} is broken, run --setup\n"
		fi
	done
}

print_runtime () {
	printf "WINE ARCH        : ${WINEARCH}\n"
	if [ "${WINEARCH}" == "win32" ]; then
		WINE="${WINE32}"
		WINESERVER="${WINESERVER32}"
	elif [ "${WINEARCH}" == "win64" ]; then
		WINE="${WINE64}"
		WINESERVER="${WINESERVER64}"
	else
		printf "ERROR : Unknown ${WINEARCH} architecture\n"
		exit 1
	fi
	printf "WINE PATH        : $(realpath ${WINE})\n"
	printf "WINE SERVER PATH : $(realpath ${WINESERVER})\n"
	printf "WINE PREFIX      : ${WINEPREFIX}\n"
}

run_executable () {
	printf "EXECUTABLE       : ${executable}\n"
	printf "PARAMETERS       : ${parameters}\n\n"
	restore_path="${PATH}"
	wine_runtime_path="$(realpath "${WINE}")" 
	PATH="${wine_runtime_path%/*}:${PATH}"
	/bin/sh -c "WINEPREFIX=\"${WINEPREFIX}\" WINEARCH=\"${WINEARCH}\" WINESERVER=\"$(realpath ${WINESERVER})\" \"$(realpath ${WINE})\" \"${executable}\" \"${parameters}\""
	PATH="${restore_path}"
}

download_runtime () {
	runtimedownload=$(curl -s https://api.github.com/repos/Kron4ek/Wine-Builds/releases | grep "browser_download_url" | cut -d\" -f4 | fzf --prompt "Select runtime to download > ")
	if [ ! -z "${runtimedownload}" ]; then
		case "${runtimedownload}" in
			*amd64*|*AMD64*)
				runtime="${WINERUNTIME64}/runtime64.tar.xz"
				wget ${runtimedownload} -O "${runtime}"
				tar xvf "${runtime}" --directory "${WINERUNTIME64}"
			;;
			*x86*|*X86*)
				runtime="${WINERUNTIME32}/runtime32.tar.xz"
				wget ${runtimedownload} -O "${runtime}"
				tar xvf "${runtime}" --directory "${WINERUNTIME32}"
			;;
			*)
				printf "ERROR : Not a supported architecture (AMD64 or X86)\n"
				exit 1
			;;
		esac
		rm "${runtime}"
	else
		printf "ERROR : Missing download runtime variable\n"
		exit 1		
	fi
}

show_usage () {
	printf "USAGE : ${0}\n"
	printf "        <32|64> EXECUTABLE {PARAMS}   : Runs executable with optional params in 32 or 64 bits mode\n"
	printf "        <32|64> EXECUTABLE winecfg    : Runs winecfg inside the executable prefix\n"
	printf "        <32|64> EXECUTABLE winetricks : Runs winetricks GUI inside the executable prefix\n"
	printf "        --setup                       : Sets up 32 and 64 Bits Runtimes\n"
	printf "        --show                        : Shows current Runtime configuration\n"
	printf "        --install-winetricks          : Installs winetricks\n"
	printf "        --download-runtime            : Downloads a runtime\n"
	printf "        --help                        : Displays this message\n"
	printf "\n"
	printf "* WINERUNTIME = ${WINERUNTIME}\n"
	printf "* WINEPREFIXES = ${WINEPREFIXES}\n"
	printf "* WINETRICKS = ${WINETRICKS}\n"
	exit 1
}

main () {
	type -P fzf &>/dev/null || { printf "ERROR : fzf was not found, install (https://github.com/junegunn/fzf) to continue\n"; exit 1; }
	mkdir -p "${WINEPREFIXES}" && mkdir -p "${WINERUNTIME}" && mkdir -p "${WINERUNTIME32}" && mkdir -p "${WINERUNTIME64}"
	if [ ! -z "${option}" ]; then
		case "${option}" in
			"32"|"64")
				if [ -z "${executable}" ]; then
					printf "ERROR : Missing executable\n"
					show_usage
				elif [ "${option}" -eq "32" ]; then
					WINEARCH="win32"
				elif [ "${option}" -eq "64" ]; then
					WINEARCH="win64"
				fi
				WINEPREFIX="${WINEPREFIXES}/prefix-$(basename "${executable}")-${WINEARCH}"
				if [ "${parameters}" == "winecfg" ]; then
					executable="winecfg"
				elif [ "${parameters}" == "winetricks" ]; then
					if [ ! -f "${WINETRICKS}" ]; then printf "ERROR : winetricks was not found, use --install-winetricks to install\n"; exit 1; fi
					executable="${WINETRICKS}"
					parameters="--gui"
				fi
				print_runtime
				run_executable
				exit 0
			;;
			"--setup")
				setup
				exit 0
			;;
			"--install-winetricks")
				wget -nv https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O "${WINETRICKS}"
				chmod +x "${WINETRICKS}"
				exit 0
			;;
			"--download-runtime")
				download_runtime
				exit 0
			;;
			"--show")
				show_config
				exit 0
			;;
			"--help")
				show_usage
				exit 0
			;;
			*)
				printf "ERROR : Invalid option \"${option}\"\n"
				show_usage
			;;
		esac
	else
		printf "ERROR : Missing parameters\n"
		show_usage
	fi
}

option="$1"
executable="$2"
parameters="${*: 3}"

main
