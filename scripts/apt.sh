#!/usr/bin/env bash

APT_PACKAGES=(
  git-all
  wget
  php
  apache2
  flatpak
  gnome-software-plugin-flatpak
  apt-transport-https
  curl
  openssh-client
  openssh-server
)

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

function add_architectures() {
  ## architecture 32 bits ##
  sudo dpkg --add-architecture i386
}

function apt_install() {
  remove_locks &&
    (
      . ./scripts/update.sh
      clear_setup
    )
  add_architectures

  for package in ${APT_PACKAGES[@]}; do
    if ! dpkg -l | grep -q "$package"; then
      printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"
      sudo apt install -y $package &>/dev/null

      if dpkg -l | grep -q "$package"; then
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
