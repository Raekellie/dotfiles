#!/usr/bin/env bash
set -e -u -o pipefail

main() {
	uptime --pretty | sed 's/up\s*/'"$1"'/' | sed -E 's/\s*day(s)?/d/' | sed -E 's/\s*hour(s)?/h/' | sed -E 's/\s*minute(s)?/m/'
}

usage() {
	printf 'Usage: %s PREFIX' "$0"
	exit 1
}

if [[ "$#" != "1" ]]; then
	usage
else
	main "$@"
fi
