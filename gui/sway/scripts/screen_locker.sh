#!/usr/bin/env bash
set -e -u -o pipefail

main() {
	# WM agnostic
	RANDR="wlr-randr --output HDMI-A-1"
	LOCKER="swaylock --config $DOTFILES/desktop/sway/swaylock.conf"

	case "$1" in
		now)
			$LOCKER
			;;
		idle)
			swayidle -w \
				timeout $((3*60)) "$LOCKER" \
				timeout $((4*60)) "$RANDR --off" resume "$RANDR --on" \
				before-sleep "$LOCKER"
			;;
		*)
			usage
			;;
	esac
}

usage() {
	printf 'Usage: %s (now|idle)' "$0"
	exit 1
}

if [[ "$#" != "1" ]]; then
	usage
else
	main "$@"
fi
