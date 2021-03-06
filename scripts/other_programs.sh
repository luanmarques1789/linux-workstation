#!/usr/bin/env bash

##############GLOBAL SCOPE##############
source /etc/os-release
#######################################

function validate_pkg() {
  local package=$1

  if dpkg -l | grep -q "\s\b${package}\b\s"; then
    printf "${GREEN}[SUCCESS]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was installed successfully!\n"
  else
    printf "${RED}[ERROR]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was not installed successfully!\n"
  fi

}

function install_nodejs() {
  local package='nodejs'

  if ! dpkg -l | grep -q "\s\b${package}\b\s"; then
    printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"
    curl -fsSL https://deb.nodesource.com/setup_18.x &>/dev/null | sudo -E bash -
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

    # specific installation for Linux distro XYZ
    if [[ $ID == 'debian' ]]; then
      download="mysql-apt-config_0.8.22-1_all.deb"

      # downloading APT MySQL repo for after installing mysql-server
      test ! -e programs/${download} && wget -q https://repo.mysql.com/${download} -P programs/

      # installing APT MySQL repo
      sudo dpkg -i programs/${download}

      pass="YES"
    fi

    update
    remove_locks
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

    sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian ${VERSION_CODENAME} contrib"

    update
    remove_locks
    sudo apt install -y "$package" &>/dev/null

    validate_pkg $package
  else
    printf "${PURPLE}[INFO]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} is already installed!\n"
  fi

}

function install_brave_browser() {
  local package="brave-browser"

  if ! dpkg -l | grep "$package" &>/dev/null; then
    printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" |
      sudo tee /etc/apt/sources.list.d/brave-browser-release.list &>/dev/null

    update
    remove_locks
    sudo apt install -y $package &>/dev/null

    validate_pkg $package
  else
    printf "${PURPLE}[INFO]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} is already installed!\n"
  fi

}

install_nodejs
install_mysql
install_virtualbox
install_brave_browser
