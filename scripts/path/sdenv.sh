#!/usr/bin/env bash
set -e -u -o pipefail

TEMP=$(mktemp)
printf 'Logs: %s\n' "$TEMP"

source $DOTFILES/gui/scripts/environment.sh

case "$1" in
	k)
		dbus-run-session startplasma-wayland &> "$TEMP"
		;;
	s)
		sway --config $DOTFILES/desktop/sway/sway.conf &> "$TEMP"
		;;
	*)
		printf 'Usage: %s (k|s)\n' "$0"
		exit 1
		;;
esac
