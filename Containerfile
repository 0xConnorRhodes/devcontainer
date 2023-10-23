FROM ubuntu:23.10

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL en_US.UTF-8

ARG USERNAME

USER root

# install updates
RUN apt-get update && \
	apt-get full-upgrade -y

# install programs
RUN apt-get install -y \
   # gen utils
	sudo \
	locales \
	psmisc \
	ffmpeg \
	bat \
	ripgrep \
   # python
	python3 \
	python3-pip \
	python3-venv \
	pipx \
	bpython \
   # networking utils
	iputils-ping \
	iproute2 \
	traceroute \
	mtr \
	nmap \
	rsync \
	curl \
	wget \
	aria2 \
   # dev tools
	git \
	jq \
	hugo \
   # gen workflow
	screen \
	fish \
	fzf \
	fd-find \
	mosh \
	zoxide \
	tree \
	lf \
	neovim

# set locale
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN echo "LANG=$LC_ALL" > /etc/locale.conf
RUN update-locale

# configure interactive user
RUN useradd -m $USERNAME && \
	usermod -a -G sudo $USERNAME && \
	chsh -s /bin/bash $USERNAME

USER $USERNAME

# install python utilities
RUN pipx install yt-dlp
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

USER root

## basic entrypoint to keep container running
CMD ["tail", "-f", "/dev/null"]
