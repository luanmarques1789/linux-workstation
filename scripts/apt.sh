#!/usr/bin/env bash

APT_PACKAGES=(
  git-all
  wget
  php
  apache2
  apt-transport-https
  curl
  openssh-client
  openssh-server
  neofetch
  net-tools
  gparted
  flameshot
)

function add_architectures() {
  ## architecture 32 bits ##
  sudo dpkg --add-architecture i386
}

function apt_install() {
  remove_locks &&
    clear_setup
  add_architectures

  for package in ${APT_PACKAGES[@]}; do
    if ! dpkg -l | grep -q "\s\b${package}\b\s"; then
      printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"
      sudo apt install -y $package &>/dev/null

      if dpkg -l | grep -q "\s\b${package}\b\s"; then
        printf "${GREEN}[SUCCESS]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was installed successfully!\n"
      else
        printf "${RED}[ERROR]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was not installed successfully!\n"
      fi

    else
      printf "${PURPLE}[INFO]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} is already installed!\n"
    fi
  done
}

apt_install
