#!/usr/bin/env bash

source ./global/color.txt

function update() {
  printf "${BLUE}[TASK]${NO_COLOR} - Updating...\n"
  sudo apt update -y &>/dev/null
}

function upgrade() {
  printf "${BLUE}[TASK]${NO_COLOR} - Upgrading...\n"
  sudo apt upgrade -y &>/dev/null
}

function clear_setup() {
  printf "${BLUE}[TASK]${NO_COLOR} - Clearing setup...\n"
  update &&
    upgrade &&
    sudo apt dist-upgrade -y &>/dev/null &&
    sudo apt autoclean -y &>/dev/null &&
    sudo apt autoremove -y &>/dev/null
}
