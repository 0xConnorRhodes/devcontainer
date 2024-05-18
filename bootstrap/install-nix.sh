#!/bin/bash

screen -dmS install-nix "sh <(curl -L https://nixos.org/nix/install) --no-daemon --yes"

sleep 5

screen -S install-nix -X stuff 'changeme\n'