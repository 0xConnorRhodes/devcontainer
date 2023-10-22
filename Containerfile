FROM alpine:latest

ARG USERNAME

USER root

RUN apk update && apk upgrade
RUN apk add \
	# utilities
	doas \
	git \
	openssh-keygen \
	openssh-client \
	chezmoi \
	mosh \
	ffmpeg \
	# networking
	rsync \
	curl \
	aria2 \
	# python
	python3 \
	py3-pip \
	# workflow
	fish \
	zoxide \
	fzf \
	screen \
	fd \
	ripgrep \
	bat \
	neovim

RUN echo "permit persist :wheel" >> /etc/doas.d/doas.conf
RUN adduser -D $USERNAME && addgroup $USERNAME wheel

USER $USERNAME
RUN mkdir $HOME/.local
RUN pip install --user pipx
RUN $HOME/.local/bin/pipx install yt-dlp

USER root
