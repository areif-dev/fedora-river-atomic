#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# Install additional repos
mkdir -p /tmp/rpms
curl -Lo /tmp/rpms/rpmfusion-free-release-${RELEASE}.noarch.rpm https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASE}.noarch.rpm
curl -Lo /tmp/rpms/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Default system packages 
rpm-ostree install -y \
    alacritty \
    bc \
    bluez \
    bluez-tools \
    cascadia-code-fonts \
    dbus-daemon \
    dbus-tools \
    distrobox \
    dunst \
    firefox \
    fontawesome-fonts \
    gnome-keyring \
    google-noto-emoji-fonts \
    grim \
    keepassxc \
    lxpolkit \
    neovim \
    papirus-icon-theme \
    pavucontrol \
    pipewire \
    playerctl \
    plocate \
    polkit \
    ranger \
    ripgrep \
    river \
    rofi-wayland \
    swaybg \
    swayidle \
    swaylock \
    thunar \
    thunar-archive-plugin \
    thunar-volman \
    vlc \
    waybar \
    wl-clipboard \
    wlr-randr \
    wireplumber \
    xdg-desktop-portal-wlr \
    xdg-user-dirs \
    xorg-x11-server-Xwayland 

# Virtualization packages 
rpm-ostree install -y \
    virt-install \
    libvirt-daemon-config-network \
    libvirt-daemon-kvm \
    qemu-kvm \
    virt-manager \
    virt-viewer \
    libguestfs-tools \
    python3-libguestfs \
    virt-top

# Wifi packages 
rpm-ostree install -y --allow-inactive \
    NetworkManager       \
    NetworkManager-tui   \
    NetworkManager-wifi  \
    atheros-firmware     \
    b43-fwcutter         \
    b43-openfwwf         \
    brcmfmac-firmware    \
    iwlegacy-firmware    \
    iwlwifi-dvm-firmware \
    iwlwifi-mvm-firmware \
    libertas-firmware    \
    mt7xxx-firmware      \
    nxpwireless-firmware \
    realtek-firmware     \
    tiwilink-firmware    \
    atmel-firmware       \
    zd1211-firmware

systemctl enable libvirtd
