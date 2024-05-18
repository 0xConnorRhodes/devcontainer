FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y screen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
