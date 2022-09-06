#!/usr/bin/env bash
set -e -u -o pipefail

main() {
	case "$1" in
		open)
			swaymsg "mode 'dash'"

			eww open-many dash-weather dash-session dash-telemetry-resources dash-telemetry-status dash-shortcuts
			wofi --show run --conf $DOTFILES/desktop/wofi/config --fork
			;;
		close)
			swaymsg "mode 'default'"

			eww close-all
			pkill wofi
			;;
		*)
			usage
			;;
	esac
}

usage() {
	printf 'Usage: %s (open|close)' "$0"
	exit 1
}

if [[ "$#" != "1" ]]; then
	usage
else
	main "$@"
fi
