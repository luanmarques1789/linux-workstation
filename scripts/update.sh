#!/usr/bin/env bash

function remove_locks() {
  path1="/var/lib/dpkg/lock-frontend"
  path2="/var/cache/apt/archives/lock"

  if [[ -d $path1 ]]; then
    sudo rm $path1 &&
      echo "lock-frontend was removed successfully"
  fi

  if [[ -d $path2 ]]; then
    sudo rm $path2 &&
      echo "lock was removed successfully"
  fi
}

function update() {
  printf "${BLUE}[TASK]${NO_COLOR} - Updating...\n" &&
    sudo apt update -y &>/dev/null
}

function upgrade() {
  printf "${BLUE}[TASK]${NO_COLOR} - Upgrading...\n" &&
    sudo apt upgrade -y &>/dev/null
}

function clear_setup() {
  printf "${BLUE}[TASK]${NO_COLOR} - Clearing setup...\n" &&
    update &&
    upgrade &&
    sudo apt dist-upgrade -y &>/dev/null &&
    sudo apt autoclean -y &>/dev/null &&
    sudo apt autoremove -y &>/dev/null
}
