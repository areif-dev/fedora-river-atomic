#!/usr/bin/env bash 

packages=$(cat /home/aur-builder/aur-packages.txt)
for package in $packages; do 
    git clone https://aur.archlinux.org/$package.git /home/aur-builder/$package
    cd /home/aur-builder/$package 
    makepkg
done
