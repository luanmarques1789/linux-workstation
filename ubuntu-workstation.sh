#!/bin/bash

## Removing evently apt blocks ##
sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock ;

## Updating the repository ##
sudo apt update &&

## Install flatpak and add flathub's repository ##
sudo apt install flatpak &&
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &&
sudo apt install gnome-software-plugin-flatpak && # flatpak's GUI

# Install flatpak's apps
flatpak install -y flathub com.discordapp.Discord --user && 
flatpak install -y flathub io.dbeaver.DBeaverCommunity --user &&
