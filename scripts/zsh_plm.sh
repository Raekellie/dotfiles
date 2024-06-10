#!/usr/bin/env -S bash -Eeuo pipefail

# Featuring `printf`s and `git pull`s, a "Plugin Manager" written by yours truly!
# Minimal *and* works! It even has colors!

PLUGINS_FOLDER="$XDG_DATA_HOME/zsh_plm"

COLOR="tput setaf 6"
RESET="tput sgr0"

declare -a REPOS=(
#"https://github.com/romkatv/zsh-defer"

"https://github.com/zdharma-continuum/fast-syntax-highlighting"
"https://github.com/zsh-users/zsh-autosuggestions"
)

main() {
	case "$1" in
		update)
			mkdir -p "$PLUGINS_FOLDER"
			for PLUGIN in "${REPOS[@]}"; do
				printf "=> $($COLOR)"'%s'"$($RESET)...\n" "$PLUGIN"

				cd "$PLUGINS_FOLDER"
				DIR="${PLUGIN##*/}"

				if ! [ -d $DIR ]; then
					git clone "$PLUGIN" --depth=1
				else
					cd "$DIR"
					git pull --force
				fi
			done
			;;
		list)
			for PLUGIN in "${REPOS[@]}"; do
				FILE="${PLUGIN##*/}"
				printf '%s/%s/%s.plugin.zsh\n' "$PLUGINS_FOLDER" "$FILE" "$FILE"
			done
			;;
		*)
			usage
			;;
	esac
}

usage() {
	printf 'Usage: %s {update,list}\n' "$0"
	exit 1
}

if [[ "$#" != "1" ]]; then
	usage
else
	main "$@"
fi
