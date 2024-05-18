FROM nixos/nix

USER root

COPY configuration.nix /etc/nixos/configuration.nix

RUN nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix

USER connor
CMD ["/bin/bash"]
