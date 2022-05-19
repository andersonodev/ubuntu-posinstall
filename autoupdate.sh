#!/usr/bin/env bash
set -e

#
# Ubuntu-postinstall.sh - Instalar e configura programas no Ubuntu (22.04 LTS ou superior)
#
# Website:       oieanderson.me
# Autor:         Anderson Lima
#
# ------------------------------------------------------------------------ #
#
# COMO USAR?
# $ ./ubuntu-postinstall.sh
#

#==============================================================================================
#==============================================================================================
#==============================================================================================



# ---------------------------------FUNÇÕES--------------------------------------------- #

apt_update(){
  sudo apt update && sudo apt dist-upgrade
}

# -------------------------------CORES PARA USAR--------------------------------------------- #

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'
# ------------------------------------------------------------------------------------------- #


echo -e "${VERDE}[INFO] - ATUALIZANDO SNAP! :)${SEM_COR}"
sudo snap refresh;
echo -e "${VERDE}[INFO] - ATUALIZANDO FLATPAK! :)${SEM_COR}"
flatpak update;
echo -e "${VERDE}[INFO] - ATUALIZANDO UPDATE! :)${SEM_COR}"
apt_update -y
echo -e "${VERDE}[INFO] - ATUALIZANDO UPDATE E DIST-UPGRADE! :)${SEM_COR}"
sudo apt update && sudo apt dist-upgrade -y
echo -e "${VERDE}[INFO] - ATUALIZANDO UPGRADE! :)${SEM_COR}"
sudo apt upgrade
echo -e "${VERDE}[INFO] - AUTOREMOVE INICIADO! :)${SEM_COR}"
sudo apt autoremove -y
echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"