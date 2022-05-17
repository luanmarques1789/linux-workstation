#!/usr/bin/env bash

function remove_locks() {
  local path1="/var/lib/dpkg/lock-frontend"
  local path2="/var/cache/apt/archives/lock"
  local path3="/var/lib/apt/lists/lock"
  local path4="/var/lib/dpkg/lock"

  if [[ -d $path1 ]]; then
    sudo rm $path1 || printf "${RED}[ERROR]${NO_COLOR} - failed removing $path1"
  fi

  if [[ -d $path2 ]]; then
    sudo rm $path2 || printf "${RED}[ERROR]${NO_COLOR} - failed removing $path2"
  fi

  if [[ -d $path3 ]]; then
    sudo rm $path3 || printf "${RED}[ERROR]${NO_COLOR} - failed removing $path3"
  fi

  if [[ -d $path4 ]]; then
    sudo rm $path4 || printf "${RED}[ERROR]${NO_COLOR} - failed removing $path4"
  fi

  # reconfigure the packages
  sudo dpkg --configure -a
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
