#!/bin/bash

# Colors
red=$'\e[1;31m'
orange=$'\e[1;33m'
blue=$'\e[1;34m'
violet=$'\e[1;35m'
green=$'\e[1;32m'
white=$'\e[1;37m'
reset=$'\e[0m'

clear_dotfiles() {
    echo "${white}> Clear old files..${reset}"
    rm -r ./config
    rm -r ./bin
    rm ./Xresources
    rm -r ./fonts
}

clear_dotfiles

# Copy files from .config directory
mkdir config
echo "${red}> Copy configs..${reset}"
cp -r $HOME/.config/awesome ./config
cp -r $HOME/.config/fontconfig ./config
cp -r $HOME/.config/redshift ./config
cp -r $HOME/.config/ranger ./config
cp -r $HOME/.config/mpd ./config
cp -r $HOME/.config/ncmpcpp ./config
cp -r $HOME/.config/cava ./config
cp -r $HOME/.config/rofi ./config
cp $HOME/.config/compton.conf ./config

# Copy binaries
echo "${orange}> Copy binaries..${reset}"
cp -r $HOME/bin ./

# Xresources
echo "${blue}> Copy Xresources..${reset}"
cp $HOME/.Xresources ./Xresources

# Fonts
echo "${violet}> Copy fonts..${reset}"
cp -r $HOME/.local/share/fonts ./
rm ./fonts/.uuid

echo "${green}Dotfiles copied.${reset}"
