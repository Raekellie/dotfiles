#!/usr/bin/env -S bash -Eeuo pipefail

eval `ssh-agent -s`
ssh-add ~/.ssh/id_saturn
