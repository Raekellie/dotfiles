#!/usr/bin/env bash
set -e -u -o pipefail

eww --config "$DOTFILES/gui/eww" open-many --toggle dash-weather dash-session dash-telemetry-resources dash-telemetry-status dash-shortcuts
