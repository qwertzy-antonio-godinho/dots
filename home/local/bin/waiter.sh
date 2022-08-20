#! /bin/sh

WINBIN="/backup/Games/winbin"
WINERUNTIME="${WINBIN}/runtime"
WINEPREFIXES="${WINBIN}/prefixes"

# 32 Bits
WINE32="${WINBIN}/wine32"
WINEDLLPATH32="${WINBIN}/lib32"
WINESERVER32="${WINBIN}/wineserver32"

# 64 Bits
WINE64="${WINBIN}/wine64"
WINEDLLPATH64="${WINBIN}/lib64"
WINESERVER64="${WINBIN}/wineserver64"

function setup () {
	# 32 Bits
	RUNTIME32=$(find ${WINERUNTIME}/32bits/* -maxdepth 1 -mindepth 1 -type d | fzf --prompt "Select 32 Bits runtime > ")
	if [ ! -z ${RUNTIME32} ]; then
		ln -sf ${RUNTIME32}/bin/wine ${WINE32}
		ln -sf ${RUNTIME32}/bin/wineserver ${WINESERVER32}
		if [ -d "${WINEDLLPATH32}" ]; then
			unlink ${WINEDLLPATH32}
		fi
		ln -s ${RUNTIME32}/lib ${WINEDLLPATH32}
	else
		printf "ERROR : Missing 32 Bits Runtime variable\n"
		exit 127
	fi
	# 64 Bits
	RUNTIME64=$(find ${WINERUNTIME}/64bits/* -maxdepth 1 -mindepth 1 -type d | fzf --prompt "Select 64 Bits runtime > ")
	if [ ! -z ${RUNTIME64} ]; then
		ln -sf ${RUNTIME64}/bin/wine ${WINE64}
		ln -sf ${RUNTIME64}/bin/wineserver ${WINESERVER64}
		if [ -d "${WINEDLLPATH64}" ]; then
			unlink ${WINEDLLPATH64}
		fi
		ln -s ${RUNTIME64}/lib ${WINEDLLPATH64}
	else
		printf "ERROR : Missing 64 Bits Runtime variable\n"
		exit 127		
	fi
}

function show_config () {
	ls -la lib32 lib64 wine32 wine64 wineserver32 wineserver64| awk '{ print $9, "---> " $NF }'
}

function print_runtime () {
	printf "WINE ARCH        : ${WINEARCH}\n"
	if [ "${WINEARCH}" == "win32" ]; then
		WINE=${WINE32}
		WINESERVER=${WINESERVER32}
	elif [ "${WINEARCH}" == "win64" ]; then
		WINE=${WINE64}
		WINESERVER=${WINESERVER64}
	else
		printf "ERROR : Unknown ${WINEARCH} architecture\n"
		exit 127
	fi
	printf "WINE PATH        : $(realpath $WINE)\n"
	printf "WINE SERVER PATH : $(realpath $WINESERVER)\n"
	printf "WINE PREFIX      : ${WINEPREFIX}\n"
}

function run_executable () {
	printf "EXECUTABLE       : ${executable}\n"
	printf "PARAMETERS       : ${parameters}\n\n"
	wine_runtime_path="$(realpath "${WINE}")" 
	PATH="${wine_runtime_path%/*}:${PATH}"
	/bin/sh -c "WINEPREFIX=\"${WINEPREFIX}\" WINEARCH=\"${WINEARCH}\" WINESERVER=\"$(realpath "${WINESERVER}")\" $(realpath "${WINE}") "${executable}" "${parameters}""
	PATH="${restore_path}"
}

function show_usage () {
	printf "USAGE : ${0} <32|64> EXECUTABLE {PARAMS}   : Runs executable with optional params in 32 or 64 bits mode\n"
	printf "USAGE : ${0} <32|64> EXECUTABLE winecfg    : Runs winecfg inside the executable prefix\n"
	printf "USAGE : ${0} <32|64> EXECUTABLE winetricks : Runs winetricks GUI inside the executable prefix\n"
	printf "        ${0} --setup                       : Sets up 32 and 64 Bits Runtimes\n"
	printf "        ${0} --show                        : Shows current Runtime configuration\n"
	printf "        ${0} --install-winetricks          : Installs WineTricks\n"
	printf "        ${0} --help                        : Displays this message\n"
	exit 127
}

function main () {
	mkdir -p "${WINEPREFIXES}" && mkdir -p "${WINERUNTIME}"
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
					executable="winetricks"
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
				winetricks_path="${WINBIN}/winetricks"
				wget -nv https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O "${winetricks_path}"
				chmod +x "${winetricks_path}"
				exit 0
			;;
			"--show")
				show_config
				exit 0
			;;
			"--help")
				show_usage
				exit0
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
