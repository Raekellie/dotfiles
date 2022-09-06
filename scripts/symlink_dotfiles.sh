#!/usr/bin/env bash
set -e -u -o pipefail

COLOR="tput setaf 6"
RESET="tput sgr0"

declare -A HOME_FILES=(
[".zshenv"]="tui/zsh/.zshenv"
)
declare -A XDG_CONFIG_HOME_FILES=(
["gdb"]="tui/gdb"
["ranger"]="tui/ranger"

["locale.conf"]="gui/locale.conf"
["environment.d"]="gui/environment.d"
["user-dirs.dirs"]="gui/user-dirs.dirs"
["user-dirs.locale"]="gui/user-dirs.locale"
)


# (existing, new)
symlink() {
	printf "$($COLOR)"'%s'"$($RESET) -> $($COLOR)"'%s'"$($RESET)\n" "$2" "$1"
	ln -sTf "$1" "$2"
}

# (array, directory)
handle_array() {
	# https://stackoverflow.com/questions/4069188
	eval "declare -A arr="${1#*=}
	for file in "${!arr[@]}"; do
		EXISTING=$DOTFILES/${arr[$file]}
		NEW=$2/$file

		symlink "$EXISTING" "$NEW"
	done
}

printf '=> %s...\n' "$HOME"
handle_array "$(declare -p HOME_FILES)" "$HOME"

printf '=> %s...\n' "$XDG_CONFIG_HOME"
handle_array "$(declare -p XDG_CONFIG_HOME_FILES)" "$XDG_CONFIG_HOME"
