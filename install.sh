#!/usr/bin/env bash

# Printing messages
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

info() {
  printf "${GREEN}$@${NC}\n"
}

error() {
  printf "${RED}Error: $@${NC}\n" 1>&2
}

fail() {
  error "$@"
  exit 1
}

info "Checking environment variables are defined..."

declare -a vars=(
  "II_CLONE_PATH"
  "GITHUB_USERNAME"
  "GITHUB_ACCESS_TOKEN"
  "CLOUDANT_USERNAME"
  "CLOUDANT_AUTHORIZATION_HEADER"
)

for var in "${vars[@]}"
do
    value="${!var}"
    if [ -z "${value}" ]; then
        fail "Environment variable '$var' is not set"
    fi
done

info "Checking docker is installed..."

declare -a commands=(
  "docker"
  "docker-compose"
)

for cmd in "${commands[@]}"
do
    if ! [ -x "$(command -v $cmd)" ]; then
      fail "$cmd is not installed"
      exit 1
    fi
done


info "Checking $II_CLONE_PATH exists"

if [ ! -d "$II_CLONE_PATH" ]; then
    printf "Creating $II_CLONE_PATH\n"
    mkdir -p "$II_CLONE_PATH"
fi;

info "Cloning repos to $II_CLONE_PATH"

cd $II_CLONE_PATH

declare -a repos=(
  "git@github.com:${GITHUB_USERNAME}/scheduler.git"
  "git@github.com:${GITHUB_USERNAME}/django_scheduler.git"
  "git@github.com:${GITHUB_USERNAME}/runner.git"
)

for repo in "${repos[@]}"
do
    printf "Cloning $repo\n"
    git clone $repo > /dev/null 2>&1
done


info "Building base images"

cd runner/ii

declare -a baseimgs=(
  "base"
  "basenodejs"
  "basescala"
)

for img in "${baseimgs[@]}"
do
    docker-compose build $img
done
