#!/usr/bin/env bash

source ./global/color.txt

function get_user() {
  printf "Current user: ${ORANGE}$(whoami)${NO_COLOR}\n"
  printf "Machine: ${ORANGE}$(hostname)${NO_COLOR}\n"
}

function test_internet_conection() {
  echo "Testing internet connection..."

  if ! ping -qc 4 google.com &>/dev/null; then
    echo -e "${RED}[ERROR]${NO_COLOR} - No internet connection!"
    exit 1
  else
    printf "${GREEN}[SUCCESS]${NO_COLOR} - You have internet connection!\n"
  fi
}

get_user
test_internet_conection
DIR=$(dirname "$0")

(
  source scripts/apt.sh
  source scripts/flatpak.sh
)

printf "\nRestart machine for changes will be affected\n"
