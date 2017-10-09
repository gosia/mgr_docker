FROM ubuntu:14.04

RUN apt-get update -y && \
    apt-get install git curl build-essential -y && \
    git config --global user.email "docker@cs.uni.wroc.pl" && \
    git config --global user.name "Docker" && \
    mkdir /app

WORKDIR /app
