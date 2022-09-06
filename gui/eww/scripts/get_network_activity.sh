#!/usr/bin/env bash
set -e -u -o pipefail

main() {
	case "$2" in
		upload)
			COLUMN=8
			;;
		download)
			COLUMN=6
			;;
		*)
			usage
			;;
	esac

	ifstat "$1" | awk 'NR==4 {print $'"$COLUMN"'}'
}

usage() {
	printf 'Usage: %s INTERFACE (upload|download)' "$0"
	exit 1
}

if [[ "$#" != "2" ]]; then
	usage
else
	main "$@"
fi
