#!/bin/sh
# script runs as nonroot user

/home/connor/.local/bin/chezmoi init --apply 0xConnorRhodes

sh -c "tail -f /dev/null"