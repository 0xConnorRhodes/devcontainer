#!/usr/bin/expect -f

# Variables
set timeout 10
set user_password "changeme"

# Spawn the command that requires the password
spawn /opt/boostrap/install-nix.sh --no-daemon --yes

# Handle the password prompt
expect "password for connor:"
send "$user_password\r"

# Interact with the spawned process
interact