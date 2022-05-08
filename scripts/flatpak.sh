#!/usr/bin/env bash

source ./global/color.txt

FLATPAK_PACKAGES=(
  com.discordapp.Discord
  io.dbeaver.DBeaverCommunity
  org.mozilla.Thunderbird
  org.gnome.DejaDup.Locale
  org.flameshot.Flameshot
  com.spotify.Client
)

function flatpak_add() {
  app=$1
  sudo flatpak install -y flathub $app &>/dev/null
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

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
install_flatpak_apps
