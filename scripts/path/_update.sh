#!/usr/bin/env -S bash -Eeuo pipefail

# (text) -> ()
msg() {
	COLOR="tput setaf 6"
	RESET="tput sgr0"

	printf "$($COLOR)"'[I] %s'"$($RESET)" "$1"
}

# (command) -> ()
cmd() {
	echo ' | '"$@"
	eval "$@"

	# printf runs for every arg in $@ which is weird
	#printf '%s' "$@"
}

msg "System packages"
cmd paru

msg "Rust"
cmd rustup update stable

msg "ZSH plugins"
cmd $DOTFILES/tui/zsh/plm.sh update

msg "Vim plugins"
cmd vim +PlugUpdate +qa # still not sure which looks fancier between `-c ":CMD"` and `+CMD`

msg "Done!"
echo ""
