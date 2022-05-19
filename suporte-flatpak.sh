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

# -------------------------------CORES PARA USAR--------------------------------------------- #

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'
# ------------------------------------------------------------------------------------------- #


# -------------------------------- PROGRAMAS .DEB --------------------------------------------- #

##LIST
programas=(
  flatpak
  gnome-software-plugin-flatpak
)

# Instalar programas no apt
echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"

for programas in ${programas[@]}; do
  if ! dpkg -l | grep -q $programas; then # Só instala se já não estiver instalado
    sudo apt install "$programas" -y;
  else
    echo "[INSTALADO] - $programas"
  fi
done
# --------------------------------------------------------------------------------------------- #



# --------------------------- Repositório Flathub ---------------------------------------------- #

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# ---------------------------------------------------------------------------------------------- #