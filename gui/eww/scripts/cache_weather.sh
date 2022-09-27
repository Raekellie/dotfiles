#!/usr/bin/env -S bash -Eeuo pipefail

# $1 | cache duration: how long to cache the report for, in seconds

IMG="/tmp/$(whoami)-cached-weather-report"

get_report() {
	COORDS=$(cat "$HOME/documents/coords.txt")
	REQUEST="https://wttr.in/${COORDS}_transparency=255_mQ0.png"

	wget "$REQUEST" --output-document "$IMG" --quiet

	# https://develop.kde.org/hig/style/color/dark/ -- Charcoal Gray
	convert "$IMG" -fuzz 0% -fill '#31363b' -opaque black "$IMG"
}

if ! [[ -e "$IMG" ]]; then
	get_report
elif (( $(stat -c "%Y" "$IMG") + "$1" <= $(date "+%s") )); then
	get_report
fi

printf '%s' "$IMG"
