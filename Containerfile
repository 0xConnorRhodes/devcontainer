FROM alpine:latest

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
	neovim

RUN echo "permit persist :wheel" >> /etc/doas.d/doas.conf
RUN adduser -D connor && addgroup connor wheel

USER connor
RUN mkdir $HOME/.local
RUN pip install --user pipx
RUN $HOME/.local/bin/pipx install yt-dlp

USER root
