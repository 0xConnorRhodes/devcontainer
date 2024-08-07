#!/bin/sh
# script runs as nonroot user

# deploy dotfiles
if [ -f "/home/connor/.local/share/chezmoi/README.md" ]; then
    /home/connor/.local/bin/chezmoi apply
    /home/connor/.local/bin/chezmoi apply
else
    # if the chezmoi directory does not exist, clone dotfiles and apply
    sudo chown -R 1000:1000 /home/connor/.local/bin/chezmoi
    /home/connor/.local/bin/chezmoi init --apply 0xConnorRhodes
    /home/connor/.local/bin/chezmoi apply

    # edit chezmoi git config to push using ssh
    cm_file_path="/home/connor/.local/share/chezmoi/.git/config"
    cm_old_string="https://github.com/0xConnorRhodes/dotfiles.git"
    cm_new_string="git@github.com:0xConnorRhodes/dotfiles.git"
    sed -i "s|$cm_old_string|$cm_new_string|g" "$cm_file_path"
fi

if [ ! -e "$HOME/notes" ]; then
  if [ -d "/nmount/zk_notes" ]; then
    ln -s /nmount/zk_notes "$HOME/notes"
  fi
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
