FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL en_US.UTF-8

USER root

# delete default interactive user
RUN userdel -r ubuntu

# unimimize to add help docs
RUN yes | unminimize

RUN apt-get update &&  \
    apt-get full-upgrade -y

# install programs
RUN apt-get install -y \
    # gen utils
    sudo \
	locales \
   # networking utils
	iputils-ping \
	rsync \
	curl \
	wget \
    # dev
    git \
    make \
    just \
    jq \
    tealdeer \
    lua5.4 \
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
    magic-wormhole \
    neovim

RUN apt-get autoremove
    
# set locale
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN echo "LANG=$LC_ALL" > /etc/locale.conf
RUN update-locale

# add interactive user
RUN useradd -ms /bin/bash connor
RUN usermod -aG sudo connor
RUN echo 'connor ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY bootstrap/* /opt/bootstrap/
RUN /opt/bootstrap/install-powershell.sh

# set persistent volume permissions
RUN mkdir /home/connor/.ssh && chown -R connor:connor /home/connor/.ssh
RUN mkdir /home/connor/code && chown -R connor:connor /home/connor/code

# set run context for container
USER connor
WORKDIR /home/connor
RUN tldr --update

# install chezmoi (dotfiles deployed in bootstrap/entrypoint.sh)
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

ENTRYPOINT ["/opt/bootstrap/entrypoint.sh"]