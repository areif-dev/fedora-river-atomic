FROM quay.io/fedora/fedora-coreos:testing

RUN rpm-ostree install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# System 
RUN rpm-ostree install -y \
    bluez \
    bluez-tools \
    dbus \
    dbus-daemon \
    dbus-tools \
    dunst \
    gnome-keyring \
    gvfs-mtp \
    grim \
    jmtpfs \
    lxpolkit \
    openssh \
    openssl \
    papirus-icon-theme \
    pipewire \
    plocate \
    polkit \
    river \
    rofi-wayland \
    swaybg \
    swayidle \
    swaylock \
    waybar \
    wl-clipboard \
    wlr-randr \
    wireplumber \
    xdg-desktop-portal-wlr \
    xdg-user-dirs \
    xorg-x11-server-Xwayland 

# Applications 
RUN rpm-ostree install -y \
    alacritty \
    bc \
    distrobox \
    firefox \
    keepassxc \
    kpcli \
    krita \
    libreoffice \
    neovim \
    openvpn \
    pavucontrol \
    playerctl \
    ranger \
    ripgrep \
    thunar \
    thunar-archive-plugin \
    thunar-volman \
    torbrowser-launcher \
    unzip \
    vlc  \
    zip

# Fonts 
RUN rpm-ostree install -y \
    cascadia-code-fonts \
    fontawesome-fonts \
    google-noto-emoji-fonts \

# Virtualization packages 
RUN rpm-ostree install -y \
    virt-install \
    libvirt-daemon-config-network \
    libvirt-daemon-kvm \
    qemu-kvm \
    virt-manager \
    virt-viewer \
    libguestfs-tools \
    python3-libguestfs \
    virt-top && \
    systemctl enable libvirtd

# Wifi packages 
RUN rpm-ostree install -y --allow-inactive \
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

RUN mkdir -p /var/lib/alternatives && \
    ostree container commit
## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit
