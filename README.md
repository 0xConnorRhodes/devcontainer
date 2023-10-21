# DevContainer
Interactive software development and DevOps container environment

## Initial setup
1. Install Docker, Podman, Distrobox, etc. on host machine
2. Clone repo and build image (see Makefile)
3. On first launch, run `doas chown -R connor:wheel ~/.local/share` and rebuild container to allow programs to save their state onto the newly created `devct_persist` volume.
