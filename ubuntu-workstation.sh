#!/bin/bash

## DEFINING FUNCTIONS ##

update() {
  sudo apt update -y
}

upgrade() {
  sudo apt upgrade -y
}

clear_setup() {
  update &&
  sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y
}

remove_locks() {
  path1="/var/lib/dpkg/lock-frontend"
  path2="/var/cache/apt/archives/lock"

  if [[ -d $path1 ]]; then
    sudo rm $path1;
  fi

  if [[ -d $path2 ]]; then
    sudo rm $path2;
  fi
}


add_architectures() {
  ## architecture 32 bits ##
  sudo dpkg --add-architecture i386;
}

apt_add() {
  sudo apt install -y apt-transport-https curl git-all
}

pre_install_flatpak() {
  ## Install flatpak and add flathub's repository ##
  sudo apt install -y flatpak &&
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &&
  sudo apt install -y gnome-software-plugin-flatpak # flatpak's GUI
}

flatpak_add() {
  app=$1
  sudo flatpak install -y $app --user;
}

install_flatpak_apps(){
  pre_install_flatpak &&
  flatpak_add com.discordapp.Discord
  flatpak_add io.dbeaver.DBeaverCommunity
  flatpak_add org.mozilla.Thunderbird
}

add_brave() {
  update &&
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \ 
    https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg &&

  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] \
    https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list &&

  update && upgrade &&
  sudo apt install -y brave-browser;
}

## RUN FUNCTIONS ##

remove_locks
add_architectures
clear_setup &&
apt_add &&
add_brave
install_flatpak_apps
clear_setup
echo "Script finished!"