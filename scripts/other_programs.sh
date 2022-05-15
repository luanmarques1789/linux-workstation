#!/usr/bin/env bash

function validate_pkg() {
  local package=$1

  if dpkg -l | grep -q "$package"; then
    printf "${GREEN}[SUCCESS]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was installed successfully!\n"
  else
    printf "${RED}[ERROR]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was not installed successfully!\n"
  fi

}

function install_nodejs() {
  local package=nodejs

  if ! dpkg -l | grep -q "$package"; then
    printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"
    curl -fsSL https://deb.nodesource.com/setup_18.x &>/dev/null | sudo -E bash - &&
      sudo apt install -y $package &>/dev/null

    validate_pkg $package

  else
    printf "${PURPLE}[INFO]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} is already installed!\n"
  fi
}

function install_mysql() {
  local package="mysql-server"

  if ! dpkg -l | grep -q "$package"; then
    printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"

    source /etc/os-release

    # specific installation for Linux distro XYZ
    if [[ $ID == 'debian' ]]; then
      download="mysql-apt-config_0.8.22-1_all.deb"

      # downloading APT MySQL repo for after installing mysql-server
      test ! -e programs/${download} && wget -q https://repo.mysql.com/${download} -P programs/

      # installing APT MySQL repo
      sudo dpkg -i programs/${download} &&
        update

      pass="YES"
    fi

    [[ $pass == "YES" ]] && printf "${BLUE}[TASK]${NO_COLOR} - Still installing...\n"
    sudo apt install -y $package
    validate_pkg $package
  else
    printf "${PURPLE}[INFO]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} is already installed!\n"
  fi
}

function install_virtualbox() {
  package='virtualbox'

  if ! dpkg -l | grep -q "$package"; then
    printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"

    source /etc/os-release
    mydist=$VERSION_CODENAME

    sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian ${mydist} contrib" &&
      sudo apt install -y "$package" &>/dev/null

    validate_pkg $package
  else
    printf "${PURPLE}[INFO]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} is already installed!\n"
  fi

}

remove_locks && update && upgrade
# install_nodejs
# install_mysql
install_virtualbox
