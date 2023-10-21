FROM alpine:latest

ARG PASS

RUN apk update && apk upgrade

RUN apk add \
	doas

RUN echo "permit persist :wheel" >> /etc/doas.d/doas.conf
RUN adduser -D -G wheel connor && \
	echo "connor:$PASS" | chpasswd

# basic entrypoint to keep container running
CMD ["tail", "-f", "/dev/null"]
