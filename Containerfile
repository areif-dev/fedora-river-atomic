FROM quay.io/fedora/fedora-coreos:testing

# Update packages that commonly cause build issues
RUN rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        nfs-utils-coreos \
        || true && \
    ostree container commit

# Install extra repositories 
RUN rpm-ostree install -y --allow-inactive \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    curl -Lo /etc/yum.repos.d/_copr_areif-dev-river-bsp-layout.repo https://copr.fedorainfracloud.org/coprs/areif-dev/river-bsp-layout/repo/fedora-"$(rpm -E %fedora)"/areif-dev-river-bsp-layout-fedora-"$(rpm -E %fedora)".repo && \
    curl -Lo /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
    ostree container commit

# System 
RUN rpm-ostree install -y --allow-inactive \
    bluez \
    bluez-tools \
    cockpit \
    cockpit-machines \
    cockpit-ostree \
    cockpit-podman \
    cockpit-system \
    cockpit-ws \
    cups \
    dbus \
    dbus-daemon \
    dbus-tools \
    dunst \
    flatpak \
    gnome-keyring \
    gvfs-mtp \
    grim \
    hyprland \
    jmtpfs \
    lxpolkit \
    man-db \
    man-pages \
    openssh \
    openssl \
    papirus-icon-theme \
    pipewire \
    plocate \
    podman \
    podman-compose \
    polkit \
    river \
    river-bsp-layout \
    rofi-wayland \
    swaybg \
    swayidle \
    swaylock \
    syncthing \
    system-config-printer \
    tailscale \
    waybar \
    wl-clipboard \
    wlr-randr \
    wireplumber \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal-hyprland \
    xdg-user-dirs \
    xorg-x11-server-Xwayland \
    zsh \
    zsh-autosuggestions && \
    ostree container commit

# Applications 
RUN rpm-ostree install -y --allow-inactive \
    alacritty \
    bc \
    distrobox \
    ffmpeg \
    firefox \
    gnome-boxes \
    htop \
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
    thunderbird \
    unzip \
    vlc  \
    zip && \
    ostree container commit

# Fonts 
RUN rpm-ostree install -y --allow-inactive \
    cascadia-code-fonts \
    fontawesome-fonts \
    google-noto-emoji-fonts  && \
    ostree container commit

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
    zd1211-firmware   && \
    ostree container commit 

RUN mkdir -p /tmp/extras
COPY ./extras.sh /tmp/extras/extras.sh
RUN /tmp/extras/extras.sh && \
    rm -rf /tmp/extras && \
    ostree container commit

# Enable services
RUN systemctl enable plocate-updatedb  && \
    mkdir -p /var/lib/plocate && \
    systemctl enable tailscaled && \
    ostree container commit

## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit
RUN mkdir -p /var/lib/alternatives && \
    ostree container commit
