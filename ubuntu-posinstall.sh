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
#   $ ./ubuntu-postinstall.sh
#


#==============================================================================================
#==============================================================================================
#==============================================================================================



# ---------------------------------FUNÇÕES--------------------------------------------- #

apt_update(){
  sudo apt update && sudo apt dist-upgrade
}


## Removendo travas eventuais do apt ##
travas_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
}
travas_apt

## Atualizando o repositório ##
sudo apt update -y
# ------------------------------------------------------------------------------------------- #

#==============================================================================================


# -------------------------------CORES PARA USAR--------------------------------------------- #

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'
# ------------------------------------------------------------------------------------------- #

#==============================================================================================

# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando.${SEM_COR}"
fi

# wget está instalado?
if [[ ! -x $(which wget) ]]; then
  echo -e "${VERMELHO}[ERRO] - O programa wget não está instalado.${SEM_COR}"
  echo -e "${VERDE}[INFO] - Instalando o wget...${SEM_COR}"
  sudo apt install wget -y &> /dev/null
else
  echo -e "${VERDE}[INFO] - O programa wget já está instalado.${SEM_COR}"
fi
# --------------------------------------------------------------------------------------------- #

#==============================================================================================

# --------------------------------- PROGRAMAS EXTERNOS ------------------------------------------------ #

##URLS
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.20.3-1_amd64.deb"
URL_ELECTRUM_APPIMAGE="https://download.electrum.org/4.2.1/electrum-4.2.1-x86_64.AppImage"
URL_TEAMVIEWER="https://dl.teamviewer.com/download/linux/version_15x/teamviewer_15.29.4_amd64.deb"
URL_ZOOM="https://cdn.zoom.us/prod/5.10.4.2845/zoom_amd64.deb"
URL_VIRTUAL_BOX="https://download.virtualbox.org/virtualbox/6.1.34/virtualbox-6.1_6.1.34-150636.1~Ubuntu~eoan_amd64.deb"
URL_DROPBOX="https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb"
URL_SKYPE="https://repo.skype.com/latest/skypeforlinux-64.deb"
URL_MEGA="https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megasync-xUbuntu_22.04_amd64.deb"
URL_PROTON_VPN="https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb"

##DIRETÓRIOS E ARQUIVOS
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"

## Download e instalaçao de programas externos ##
echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_TEAMVIEWER"          -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_ZOOM"                -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VIRTUAL_BOX"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DROPBOX"             -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SKYPE"               -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_MEGA"                -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_PROTON_VPN"          -P "$DIRETORIO_DOWNLOADS"
# ----------------------------------------------------------------------------------------------- #



#atualiza tudo
sudo apt-get update && sudo apt-get upgrade
apt_update -y


# --------------------------------- PROGRAMAS APT ------------------------------------------------ #

##LIST
programas=(
  snapd
  winff
  gparted
  gufw
  synaptic
  gnome-sushi 
  vlc
  code
  timeshift
  git
  xterm
  cmatrix
  htop
  idle
  vim
  plank
  wireshark
  bleachbit
  mixxx
  rawtherapee
  filezilla
  nemo
  unrar
  gdebi
  ubuntu-restricted-extras
  dconf-editor
  gnome-tweak-tool
  git
  lxqt-sudo
  curl
  fonts-hack-ttf
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

# ----------------------------------------------------------------------------------------------- #


# --------------------------------- PROGRAMAS SNAP ------------------------------------------------ #
echo -e "${VERDE}[INFO] - Instalando pacotes snap${SEM_COR}"

## Instalando pacotes Snap ##
sudo snap install authy;
sudo snap install obs-studio;
sudo snap install spotify;
sudo snap install photogimp;
sudo snap install vlc;
sudo snap install firefox;  
sudo snap install darktable; 
sudo snap install whatsdesk; 
sudo snap install stellarium-daily;
sudo snap install kdenlive;
sudo snap install okular;
sudo snap install telegram-desktop;

sudo snap install discord;
sudo snap install obs-studio;
sudo snap install pycharm-community --classic;
sudo snap install code --classic;
sudo snap install android-studio --classic;

#Not install

##sudo snap install simplenote;
##sudo snap install krita;
##sudo snap install skype;

# ----------------------------------------------------------------------------------------- #


 # --------------------------------- INSTALANDO O TEMA -------------------------------------- #
URL_FLAT_REMIX="https://github.com/daniruiz/flat-remix"
URL_FLAT_REMIX_GTK="https://github.com/daniruiz/flat-remix-gtk"

DIRETORIO_TEMA="$HOME/theme-flat-remix"

mkdir "$DIRETORIO_TEMA"

cd "$DIRETORIO_TEMA"

git clone "$URL_FLAT_REMIX"
git clone "$URL_FLAT_REMIX_GTK"

mkdir -p ~/.icons && mkdir -p ~/.themes

cd "$DIRETORIO_TEMA"

cp -r flat-remix/Flat-Remix* ~/.icons/ && cp -r flat-remix-gtk/themes/Flat-Remix-GTK* ~/.themes/

##cp -r flat-remix/Flat-remix* ~/.icons/ && cp -r flat-remix

##cp -r flat-remix-gtk/Flat-Remix-GTK* ~/.themes/
##cp -r flat-remix-gtk/themes/Flat-Remix-GTK* ~/.themes/

mkdir $HOME/Downloads/tema-baixado

##link: https://www.osradar.com/install-flat-remix-theme-ubuntu/
##link: https://github.com/daniruiz/

# ----------------------------------------------------------------------------------------- #


# --------------------------------------- PÓS-INSTALAÇÃO ------------------------------------ #
## Finalização, atualização e limpeza##
apt_update -y;
sudo apt autoremove -y;
nautilus -q
# -------------------------------------------------------------------------- #
# ----------------------------- CONFIGS ----------------------------- #

## GNOME - configurações ##

echo -e "${VERDE}[INFO] - Configurando o sistema${SEM_COR}"

#Cria pastas para produtividade no nautilus
mkdir /home/$USER/TEMP
mkdir /home/$USER/EDITAR 
mkdir /home/$USER/Resolve
mkdir /home/$USER/AppImage
mkdir /home/$USER/Vídeos/'OBS Rec'

#Adiciona atalhos ao Nautilus

if test -f "$FILE"; then
    echo "$FILE já existe"
else
    echo "$FILE não existe, criando..."
    touch /home/$USER/.config/gkt-3.0/bookmarks
fi

echo "file:///home/$USER/EDITAR 🔵 EDITAR" >> $FILE
echo "file:///home/$USER/AppImage" >> $FILE
echo "file:///home/$USER/Resolve 🔴 Resolve" >> $FILE
echo "file:///home/$USER/TEMP 🕖 TEMP" >> $FILE

#Download do Electrum AppImage
wget -c "$URL_ELECTRUM_APPIMAGE" -P /home/$USER/AppImage

## finalização
apt_update -y
sudo apt update && sudo apt dist-upgrade -y
sudo apt upgrade
sudo apt autoremove -y
echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
# -------------------------------------------------------------------------------------------- #
