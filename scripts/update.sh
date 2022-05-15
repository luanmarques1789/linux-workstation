#!/usr/bin/env bash

function remove_locks() {
  path1="/var/lib/dpkg/lock-frontend"
  path2="/var/cache/apt/archives/lock"

  if [[ -d $path1 ]]; then
    sudo rm $path1 &&
      printf "lock-frontend was removed successfully\n"
  fi

  if [[ -d $path2 ]]; then
    sudo rm $path2 &&
      printf "lock was removed successfully\n"
  fi
}

function update() {
  printf "${BLUE}[TASK]${NO_COLOR} - Updating..." &&
    sudo apt update -y &>/dev/null &&
    printf " >>> ${GREEN}Updated!${NO_COLOR}\n" ||
    printf " >>> ${RED}Failed!${NO_COLOR}\n"
}

function upgrade() {
  printf "${BLUE}[TASK]${NO_COLOR} - Upgrading..." &&
    sudo apt upgrade -y &>/dev/null &&
    printf " >>> ${GREEN}Upgraded!${NO_COLOR}\n" ||
    printf " >>> ${RED}Failed!${NO_COLOR}\n"
}

function clear_setup() {
  printf "${BLUE}[TASK]${NO_COLOR} - Clearing setup...\n" &&
    update &&
    upgrade &&
    sudo apt dist-upgrade -y &>/dev/null &&
    sudo apt autoclean -y &>/dev/null &&
    sudo apt autoremove -y &>/dev/null
}
