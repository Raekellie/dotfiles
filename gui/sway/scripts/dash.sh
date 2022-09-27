#!/usr/bin/env -S bash -Eeuo pipefail

# $1 | action: {open,close}

case "$1" in
	open)
		swaymsg "mode 'dash'"

		eww open-many dash-weather dash-session dash-telemetry-resources dash-telemetry-status dash-shortcuts
		wofi --show run --conf "$DOTFILES/desktop/wofi/config" --fork
		;;
	close)
		swaymsg "mode 'default'"

		eww close-all
		pkill wofi
		;;
esac
