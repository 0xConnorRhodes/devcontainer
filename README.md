# DevContainer
Interactive software development and DevOps container environment

## Initial setup
1. Install Docker, Podman, Distrobox, etc. on host machine
2. Clone repo and build image (see Makefile)
3. On first launch, run: 
   ```bash
   doas chown -R connor:wheel ~/.ssh
   doas chown -R connor:wheel ~/.local
   ```

4. Rebuild container to allow programs to save their state onto the newly created volumes.
