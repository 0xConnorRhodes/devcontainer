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
	cargo \
	poppler-utils \
	mediainfo \
	unzip \
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
	tealdeer \
	make \
	tmux \
	emacs \
	# needed for powershell
	libc6 \
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

# copy bootstrap scripts into the container
RUN mkdir /opt/bootstrap
COPY bootstrap/* /opt/bootstrap/
RUN /opt/bootstrap/install-magic-wormhole-rs.sh
RUN /opt/bootstrap/install-powershell.sh
RUN /opt/bootstrap/setup-powershell.ps1


# create volume mount points and set permissions
RUN mkdir /home/$USERNAME/.ssh && chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
RUN mkdir -p /home/$USERNAME/.local/share && chown -R $USERNAME:$USERNAME /home/$USERNAME/.local
RUN mkdir /home/$USERNAME/code && chown -R $USERNAME:$USERNAME /home/$USERNAME/code

# emacs
RUN mkdir /home/ubuntu/.emacs.d && chown -R ubuntu:ubuntu /home/ubuntu/.emacs.d
RUN mkdir /home/ubuntu/.doom.d && chown -R ubuntu:ubuntu /home/ubuntu/.doom.d


USER $USERNAME

RUN tldr --update
RUN cargo install --root $HOME/.local/cargo just
RUN cargo install --locked --root $HOME/.local/cargo zellij
RUN pipx install yt-dlp
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

USER root
