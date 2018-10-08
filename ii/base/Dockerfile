FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install git curl build-essential gettext-base -y && \
    git config --global user.email "docker@mail.com" && \
    git config --global user.name "Docker" && \
    mkdir /app

COPY profile /root/.profile
WORKDIR /app

ENTRYPOINT ["/bin/sh", "-lc"]
