#!/usr/bin/env -S bash -Eeuo pipefail

eww --config "$DOTFILES/gui/eww" open-many --toggle dash-weather dash-session dash-telemetry-resources dash-telemetry-status dash-shortcuts
