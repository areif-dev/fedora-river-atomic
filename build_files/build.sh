#!/usr/bin/env bash

set -ouex pipefail 

# Speed up DNF
sed -i 's/.*max_parallel_downloads=.*//g' /etc/dnf/dnf.conf && \
sed -i 's/.*fastestmirror=.*//g' /etc/dnf/dnf.conf && \
echo 'max_parallel_downloads=15' | tee -a /etc/dnf/dnf.conf && \
echo 'fastestmirror=True' | tee -a /etc/dnf/dnf.conf

dnf5 update -y

# Install Extra Repos
dnf5 install -y \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
curl -Lo /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo 

source /ctx/packages.sh
dnf5 install -y "${all_packages[@]}"

# Enable services 
# systemctl enable libvirtd 
# systemctl enable tailscaled 

# Cleanup 
dnf5 clean all 
dnf5 autoremove -y
