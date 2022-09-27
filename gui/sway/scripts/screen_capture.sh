#!/usr/bin/env -S bash -Eeuo pipefail

# $1 | action: {full,selection,color}

case "$1" in
	full)
		grim -g "0,0 1920x1080" - | wl-copy
		;;
	selection)
		grim -g "$(slurp -d)" - | wl-copy
		;;
	color)
		COLOR=$(grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n 1 | cut -d ' ' -f 4 | tr -d '\n')
		IMAGE=$(mktemp --suffix=".png")

		convert -size 24x24 canvas:"$COLOR" "$IMAGE"

		wl-copy <<< $COLOR
		notify-send "Grabbed: $COLOR" -i "$IMAGE"
		;;
esac
