#!/usr/bin/env bash
set -e -u -o pipefail

main() {
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
			notify-send "Picked and copied $COLOR" -i "$IMAGE"
			;;
		*)
			usage
			;;
	esac
}

usage() {
	printf 'Usage: %s (full|selection|color)' "$0"
	exit 1
}

if [[ "$#" != "1" ]]; then
	usage
else
	main "$@"
fi
