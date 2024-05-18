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
	iputils-ping \
	rsync \
	curl \
	wget \
    # dev tools
    git \
    make \
    just \
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

COPY bootstrap/* /opt/bootstrap/
# RUN curl -L -o /opt/bootstrap/install-nix.sh https://nixos.org/nix/install

# set run context for container
USER connor
WORKDIR /home/connor
RUN tldr --update

CMD ["/usr/bin/fish"]