FROM alpine:latest

ARG PASS
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
	aria2c \
	# python
	python3 \
	py3-pip \
	# workflow
	fish \
	zoxide \
	fzf \
	screen \
	neovim

RUN echo "permit persist :wheel" >> /etc/doas.d/doas.conf
RUN adduser -D connor && \
	addgroup connor wheel && \
	echo "connor:$PASS" | chpasswd

USER connor
RUN mkdir $HOME/.local
RUN pip install --user pipx
RUN $HOME/.local/bin/pipx install yt-dlp

USER root
# basic entrypoint to keep container running
CMD ["tail", "-f", "/dev/null"]
