#!/usr/bin/env -S bash -Eeuo pipefail

# (text) -> ()
msg() {
	COLOR="tput setaf 6"
	RESET="tput sgr0"

	printf "$($COLOR)"'[I] %s'"$($RESET)" "$1"
}

# (command) -> ()
cmd() {
	# https://stackoverflow.com/questions/56098830/how-to-printf
	printf ' | %s\n' "$*"

	eval "$*"
}

msg "System packages"
#cmd paru
cmd sudo pacman -Syu

#msg "Rust"
#cmd rustup update stable

msg "ZSH plugins"
cmd $DOTFILES/scripts/zsh_plm.sh update

msg "Vim plugins"
cmd vim +PlugUpdate +qa

msg "Done!"
echo ""
