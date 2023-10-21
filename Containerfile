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
	# workflow
	fish \
	zoxide \
	fzf \
	neovim

RUN echo "permit persist :wheel" >> /etc/doas.d/doas.conf
RUN adduser -D connor && \
	addgroup connor wheel && \
	echo "connor:$PASS" | chpasswd

USER connor
RUN mkdir $HOME/.local

USER root
# basic entrypoint to keep container running
CMD ["tail", "-f", "/dev/null"]
