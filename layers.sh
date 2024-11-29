#!/usr/bin/env bash 

# Install extra repositories 
rpm-ostree install -y --allow-inactive \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    curl -Lo /etc/yum.repos.d/_copr_areif-dev-river-bsp-layout.repo https://copr.fedorainfracloud.org/coprs/areif-dev/river-bsp-layout/repo/fedora-"$(rpm -E %fedora)"/areif-dev-river-bsp-layout-fedora-"$(rpm -E %fedora)".repo && \
    curl -Lo /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# System
rpm-ostree install -y --allow-inactive \
    bluez \
    bluez-tools \
    cockpit \
    cockpit-machines \
    cockpit-ostree \
    cockpit-podman \
    cockpit-system \
    cockpit-ws \
    dbus \
    dbus-daemon \
    dbus-tools \
    dunst \
    gnome-keyring \
    gvfs-mtp \
    grim \
    jmtpfs \
    lxpolkit \
    man-db \
    man-pages \
    openssh \
    openssl \
    papirus-icon-theme \
    pipewire \
    plocate \
    polkit \
    river \
    river-bsp-layout \
    rofi-wayland \
    swaybg \
    swayidle \
    swaylock \
    tailscale \
    waybar \
    wl-clipboard \
    wlr-randr \
    wireplumber \
    xdg-desktop-portal-wlr \
    xdg-user-dirs \
    xorg-x11-server-Xwayland \
    zsh \
    zsh-autosuggestions

# Applications 
rpm-ostree install -y --allow-inactive \
    alacritty \
    bc \
    distrobox \
    firefox \
    keepassxc \
    neovim \
    nvtop \
    openvpn \
    pavucontrol \
    playerctl \
    ranger \
    ripgrep \
    thunar \
    thunar-archive-plugin \
    thunar-volman \
    unzip \
    vlc  \
    zip

