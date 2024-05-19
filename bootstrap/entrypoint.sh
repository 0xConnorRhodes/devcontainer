#!/bin/sh
# script runs as nonroot user

# deploy dotfiles
/home/connor/.local/bin/chezmoi init --apply 0xConnorRhodes

# generate ssh key if it does not already exist in ~/.ssh
KEY_PATH="$HOME/.ssh/id_ed25519"
MACHINE=$(hostname)
if [ ! -f "$KEY_PATH" ]; then
    ssh-keygen -a 100 -t ed25519 -f $HOME/.ssh/id_ed25519 -C "connor@$MACHINE"
    echo 'generated new ssh key' >> $HOME/init-log.txt
fi

# infinite task to hold container open so shell sessions can be attached
sh -c "tail -f /dev/null"