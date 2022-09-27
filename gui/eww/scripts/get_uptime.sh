#!/usr/bin/env -S bash -Eeuo pipefail

# $1 | prefix: string that will appear the output

uptime --pretty | sed 's/up\s*/'"$1"'/' | sed -E 's/\s*day(s)?/d/' | sed -E 's/\s*hour(s)?/h/' | sed -E 's/\s*minute(s)?/m/'
