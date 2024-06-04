#!/usr/bin/env bash 

packages=$(cat /home/aur-builder/aur-packages.txt)
for package in $packages; do 
    pacman -U --noconfirm /home/aur-builder/$package/$package-*.pkg.tar*
done
