FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL en_US.UTF-8

USER root

RUN apt-get update &&  \
    apt-get full-upgrade -y

# install programs
RUN apt-get install -y \
    # gen utils
    sudo \
	locales \
	# psmisc \
    # unzip \
    # gen workflow
    screen \
    # mosh \
    # tree \
    # rust-bat \
    # ripgrep \
    # fzf \
    # fd-find \
    # fish \
    # zoxide \
    # lf \
    neovim
    
# clean package list cache
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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
CMD ["/usr/bin/fish"]