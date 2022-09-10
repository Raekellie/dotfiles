#!/usr/bin/env bash
set -e -u -o pipefail

main() {
	FILE="$XDG_MUSIC_DIR/$(ncmpcpp --quiet --current-song '%D/%f')"
	IMG="/tmp/$(whoami)-now-playing-cover.jpg"
	ffmpeg -i "$FILE" -c:v copy "$IMG" -hide_banner -loglevel error -y
	printf '%s' "$IMG"
}

usage() {
	printf 'Usage: %s' "$0"
	exit 1
}

if [[ "$#" != "0" ]]; then
	usage
else
	main "$@"
fi
