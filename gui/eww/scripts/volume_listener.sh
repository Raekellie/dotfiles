#!/usr/bin/env bash
set -e -u -o pipefail

# ((sink|source))
print_status() {
	if [[ "$(pactl get-$1-mute @DEFAULT_${1^^}@ | cut -c '7-')" = "yes" ]]; then
		case "$1" in
			sink)
				printf '‎ﱝ‎ '
				;;
			source)
				printf ' '
		esac
	fi

	pactl get-$1-volume @DEFAULT_${1^^}@ | awk 'NR==1 {print $5}'| tr -d '\n'
	echo ""
}

main() {
	# For the initial value
	print_status "$1"

	pactl subscribe | while IFS= read -r line; do
		 if [[ "$line" =~ "Event 'change' on $1 #" ]]; then
			print_status "$1"
		 fi
	 done
}

usage() {
	printf 'Usage: %s (sink|source)' "$0"
	exit 1
}

if [ "$#" != "1" ]; then
	usage
else
	main "$@"
fi
