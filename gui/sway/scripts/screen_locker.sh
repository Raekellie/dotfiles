#!/usr/bin/env -S bash -Eeuo pipefail

# $1 | trigger: {now,idle} - whether to set swayidle on a timeout or lock immediately

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
		esac
