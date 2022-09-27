#!/usr/bin/env -S bash -Eeuo pipefail

# $1 | interface: which interface to get telemetry for
# $2 | direction: {upload,download}

case "$2" in
	upload)
		COLUMN=8
		;;
	download)
		COLUMN=6
		;;
esac

ifstat "$1" | awk 'NR==4 {print $'"$COLUMN"'}'
