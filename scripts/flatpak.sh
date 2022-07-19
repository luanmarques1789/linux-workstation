#!/usr/bin/env bash

FLATPAK_PACKAGES=(
  com.discordapp.Discord
  io.dbeaver.DBeaverCommunity
  org.mozilla.Thunderbird
  org.gnome.DejaDup.Locale
  com.spotify.Client
)

function pre_install() {
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y flatpak gnome-software-plugin-flatpak

  # adding flathub's repo
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
}

function flatpak_add() {
  app=$1

  # don't use `sudo` command
  flatpak install -y --user flathub $app &>/dev/null
}

function install_flatpak_apps() {
  for package in ${FLATPAK_PACKAGES[@]}; do
    if ! flatpak list --columns=application | grep -q "$package"; then
      printf "${BLUE}[TASK]${NO_COLOR} - Installing ${ORANGE}$package${NO_COLOR}...\n"
      flatpak_add $package

      if flatpak list --columns=application | grep -q "$package"; then
        printf "${GREEN}[SUCCESS]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was installed successfully!\n"
      else
        printf "${RED}[ERROR]${NO_COLOR} - package ${ORANGE}$package${NO_COLOR} was not installed successfully!\n"
      fi

    else
      printf "${PURPLE}[INFO]${NO_COLOR} - flatpak package ${ORANGE}$package${NO_COLOR} is already installed!\n"
    fi
  done
}

pre_install
install_flatpak_apps
