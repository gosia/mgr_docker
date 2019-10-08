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
)

for var in "${vars[@]}"
do
    value="${!var}"
    if [ -z "${value}" ]; then
        fail "Environment variable '$var' is not set"
        exit 1
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
  "git@github.com:iiuni/scheduler_backend.git"
  "git@github.com:iiuni/scheduler_frontend.git"
  "git@github.com:iiuni/runner.git"
  "git@github.com:iiuni/scheduler_scripts.git"
)

for repo in "${repos[@]}"
do
    printf "Cloning $repo\n"
    git clone $repo
done


info "Building images"

cd runner/ii

declare -a baseimgs=(
  "scheduler_frontend"
  "scheduler_backend"
  "scheduler_scripts"
)

for img in "${baseimgs[@]}"
do
    docker-compose build $img
done


info "Installing projects"

docker-compose run --rm --no-deps scheduler_frontend "./scripts/install.sh"
