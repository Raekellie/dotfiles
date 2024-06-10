#!/usr/bin/env bash
set -e -u -o pipefail

#source $DOTFILES/gui/scripts/environment.sh

main() {
	TEMP=$(mktemp)
	printf '[I] Redirecting all output to %s\n' "$TEMP"

	case "$1" in
		k)
			dbus-run-session startplasma-wayland &> "$TEMP"
			;;
		s)
			printf '[E] -- not using any tiling WM at the moment; exiting'
			#sway --config $DOTFILES/desktop/sway/sway.conf &> "$TEMP"
			;;
		*)
			usage
			;;
	esac
}

usage() {
	printf 'Usage: %s (k|s)\n' "$0"
	exit 1
}

if [[ "$#" != "1" ]]; then
	usage
else
	main "$@"
fi
