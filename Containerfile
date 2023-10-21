FROM alpine:latest

RUN apk update && apk upgrade

# basic entrypoint to keep container running
CMD ["tail", "-f", "/dev/null"]
