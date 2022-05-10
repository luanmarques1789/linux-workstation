#!/usr/bin/env bash

function validate_pkg() {
  package=$1

  if dpkg -l | grep -q "$package"; then
    printf "${GREEN}[SUCCESS]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was installed successfully!\n"
  else
    printf "${RED}[ERROR]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was not installed successfully!\n"
  fi

}

function install_nodejs() {
  package=nodejs

  if ! dpkg -l | grep -q "$package"; then
    printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"
    curl -fsSL https://deb.nodesource.com/setup_18.x &>/dev/null | sudo -E bash - &&
      sudo apt install -y $package &>/dev/null

    validate_pkg $package

  else
    printf "${PURPLE}[INFO]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} is already installed!\n"
  fi
}

remove_locks && update && upgrade
install_nodejs
