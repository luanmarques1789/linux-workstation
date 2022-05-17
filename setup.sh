#!/usr/bin/env bash

#####################################################################
# AUTHOR: Luan Matheus Marques <luanmarques1789@gmail.com>
# NAME: Linux workstation setup
# VERSION: v0.1
# OFFICIAL REPOSITORY: https://github.com/luanmarques1789/linux-workstation
# DESCRIPTION: Downloader and intaller utility of packages for
# Debian-based Linux distributions
#####################################################################

#################################TEST################################
function check_dirs() {
  if [[ ! -d programs ]]; then
    mkdir programs
  fi
}

check_dirs

###########################GLOBAL VARIABLES##########################
source global/color.txt
source scripts/update.sh

###############################FUNCTIONS#############################
function get_user() {
  printf "Current user: ${ORANGE}$(whoami)${NO_COLOR}\n"
  printf "Machine: ${ORANGE}$(hostname)${NO_COLOR}\n"
}

function test_internet_conection() {
  printf "${BLUE}[TASK]${NO_COLOR} - Testing internet connection...\n"

  if ! ping -qc 4 google.com &>/dev/null; then
    printf "${RED}[ERROR]${NO_COLOR} - No internet connection!\n"
    exit 1
  else
    printf "${GREEN}[SUCCESS]${NO_COLOR} - You have internet connection!\n"
  fi
}

#################################MAIN################################
get_user
test_internet_conection

(
  source scripts/apt.sh
  source scripts/flatpak.sh
  source scripts/other_programs.sh
)

printf "\n${BOLD_RED}DISCLAIMER${NO_COLOR}: restart machine for changes will be affected!\n"
