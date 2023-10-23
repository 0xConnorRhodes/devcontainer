# DevContainer
Interactive software development and DevOps container environment

## Initial Setup
1. create a `.env` file in the repo folder in the form of `VAR=value`. The file should include a `USERNAME` and `PASS` key.
1. Install Docker, Podman, Distrobox, etc. on host machine
2. Clone repo and build image (see Makefile)
3. On first launch, run: 
   ```bash
   sudo chown -R $USER:$USER ~/.ssh
   sudo chown -R $USER:$USER ~/.local
   ```

4. Rebuild container to allow programs to save their state onto the newly created volumes.
5. Generate ssh keys: `ssh-keygen -a 100 -t ed25519 -C "user@email"`
6. run `chezmoi init --apply 0xconnorrhodes` to pull and apply dotfiles
7. configure chezmoi repo to push over ssh by replacing the `url` line in `.git/config` with the ssh url from your dotfiles repo

Note: upon container retart, run `chezmoi apply` to restore config files from `~/.local/share/chezmoi`

## Usage
Run custom screen instance/script from the host with `docker exec -it devct su -c 'screen sh' - $USER`
