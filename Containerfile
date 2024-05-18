FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL en_US.UTF-8

USER root

# delete default interactive user
RUN userdel -r ubuntu

RUN apt-get update &&  \
    apt-get full-upgrade -y

# install programs
RUN apt-get install -y \
    # gen utils
    sudo \
	locales \
	psmisc \
    unzip \
   # networking utils
	rsync \
	curl \
	wget \
    # dev tools
    git \
    make \
    jq \
    tealdeer \
    hugo \
    # gen workflow
    screen \
    mosh \
    tree \
    bat \
    ripgrep \
    fzf \
    fd-find \
    fish \
    zoxide \
    lf \
    neovim
    
# set locale
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN echo "LANG=$LC_ALL" > /etc/locale.conf
RUN update-locale

# add interactive user
RUN useradd -ms /bin/bash connor
RUN usermod -aG sudo connor
RUN echo 'connor:changeme' | chpasswd

# set run context for container
USER connor
WORKDIR /home/connor

RUN curl -L -o /tmp/nix-install.sh https://nixos.org/nix/install
RUN chmod +x /tmp/nix-install.sh
RUN /tmp/nix-install.sh --no-daemon
RUN nix-env -iA nixpkgs.powershell
RUN tldr --update

CMD ["/usr/bin/fish"]