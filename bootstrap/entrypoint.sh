#!/bin/sh
# script runs as nonroot user

# deploy dotfiles
CHEZMOI_DIR="$HOME/.local/share/chezmoi"
if [ ! -d "$CHEZMOI_DIR" ]; then
    # if the chezmoi directory does not exist, clone dotfiles and apply
    /home/connor/.local/bin/chezmoi init --apply 0xConnorRhodes

    # edit chezmoi git config to push using ssh
    cm_file_path="/home/connor/.local/share/chezmoi/.git/config"
    cm_old_string="https://github.com/0xConnorRhodes/dotfiles.git"
    cm_new_string="git@github.com:0xConnorRhodes/dotfiles.git"
    sed -i "s|$cm_old_string|$cm_new_string|g" "$cm_file_path"

    touch $HOME/new-chezmoi
else
    /home/connor/.local/bin/chezmoi apply
fi



# generate ssh key if it does not already exist in ~/.ssh
KEY_PATH="$HOME/.ssh/id_ed25519"
MACHINE=$(hostname)
if [ ! -f "$KEY_PATH" ]; then
    ssh-keygen -a 100 -t ed25519 -f $HOME/.ssh/id_ed25519 -C "connor@$MACHINE"
    echo 'generated new ssh key' >> $HOME/init-log.txt
fi

# update fish shell completions (needec because they are persistent on a bind mount)
fish -c fish_update_completions

sudo touch /opt/bootstrap/startup-finished

# infinite task to hold container open so shell sessions can be attached
sh -c "tail -f /dev/null"
