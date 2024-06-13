#!/bin/bash

CWD=`pwd`
ISONAME="m0n4rch"
USERNM="m0n4rch"
USERPASSWD="m0n4rch"
ROOTPASSWD="toor"
HSTNM="m0n4rch"

# FUNCTIONS

rootuser() {
    if [[ "$EUID" = 0 ]]; then
        continue
    else
        echo "Please run as root"
        sleep 2
        exit
    fi
}

# Display error
handlerror() {
    clear
    set -uo pipefail
    trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
}

# Prepare pacman.conf
preppacman() {
    sed "s@file:\/\/.*@file:\/\/${CWD}\/custom@g" pacman_base.conf > pacman.conf
}

# Clean Work directories
cleanup() {
    [[ -d ./${ISONAME} ]] && rm -r ./${ISONAME}
    [[ -d ./work ]] && rm -r ./work
    [[ -d ./out ]] && rm -r ./out
    sleep 2
}

# Requirements
prepreqs() {
    pacman -S --needed --noconfirm archiso mkinitcpio-archiso
}

# Copy releng
cpreleng() {
    cp -r /usr/share/archiso/configs/releng/ ./${ISONAME}
    rm ./${ISONAME}/airootfs/etc/motd
    rm ./${ISONAME}/airootfs/etc/mkinitcpio.d/linux.preset
    rm ./${ISONAME}/airootfs/etc/ssh/sshd_config.d/10-archiso.conf
    rm -r ./${ISONAME}/grub
    rm -r ./${ISONAME}/efiboot
    rm -r ./${ISONAME}/syslinux
    rm -r ./${ISONAME}/airootfs/etc/xdg
    rm -r ./${ISONAME}/airootfs/etc/mkinitcpio.conf.d
}

# Remove auto-login, cloud-init, hyper-v, iwd, sshd, resolv.conf
rmunitsd() {
    rm -r ./${ISONAME}/airootfs/etc/systemd/system/cloud-init.target.wants
    rm -r ./${ISONAME}/airootfs/etc/systemd/system/getty@tty1.service.d
    rm ./${ISONAME}/airootfs/etc/systemd/system/multi-user.target.wants/hv_fcopy_daemon.service
    rm ./${ISONAME}/airootfs/etc/systemd/system/multi-user.target.wants/hv_kvp_daemon.service
    rm ./${ISONAME}/airootfs/etc/systemd/system/multi-user.target.wants/hv_vss_daemon.service
    rm ./${ISONAME}/airootfs/etc/systemd/system/multi-user.target.wants/sshd.service
    rm ./${ISONAME}/airootfs/etc/systemd/system/multi-user.target.wants/iwd.service
    rm ./${ISONAME}/airootfs/etc/resolv.conf
}

# Add cups, haveged, NetworkManager, & sddm systemd links
addnmlinks() {
    mkdir -p ./${ISONAME}/airootfs/etc/systemd/system/network-online.target.wants
    mkdir -p ./${ISONAME}/airootfs/etc/systemd/system/multi-user.target.wants
    mkdir -p ./${ISONAME}/airootfs/etc/systemd/system/printer.target.wants
    mkdir -p ./${ISONAME}/airootfs/etc/systemd/system/sockets.target.wants
    mkdir -p ./${ISONAME}/airootfs/etc/systemd/system/timers.target.wants
    mkdir -p ./${ISONAME}/airootfs/etc/systemd/system/sysinit.target.wants
    ln -sf /usr/lib/systemd/system/NetworkManager-wait-online.service ./${ISONAME}/airootfs/etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service
    ln -sf /usr/lib/systemd/system/NetworkManager-dispatcher.service ./${ISONAME}/airootfs/etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service
    ln -sf /usr/lib/systemd/system/NetworkManager.service ./${ISONAME}/airootfs/etc/systemd/system/multi-user.target.wants/NetworkManager.service
    ln -sf /usr/lib/systemd/system/cups.service ./${ISONAME}/airootfs/etc/systemd/system/printer.target.wants/cups.service
    ln -sf /usr/lib/systemd/system/cups.socket ./${ISONAME}/airootfs/etc/systemd/system/sockets.target.wants/cups.socket
    ln -sf /usr/lib/systemd/system/cups.path ./${ISONAME}/airootfs/etc/systemd/system/multi-user.target.wants/cups.path
    ln -sf /usr/lib/systemd/system/sddm.service ./${ISONAME}/airootfs/etc/systemd/system/display-manager.service
}

# Compile Go tools
gotools() {
    mkdir -p /tmp/gotools
    GOBIN=/tmp/gotools go install github.com/tomnomnom/assetfinder@latest
    # GOBIN=/tmp/gotools go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
    # GOBIN=/tmp/gotools go install -v github.com/owasp-amass/amass/v4/...@master
    GOBIN=/tmp/gotools go install github.com/bp0lr/gauplus@latest
    GOBIN=/tmp/gotools go install github.com/deletescape/goop@latest
    GOBIN=/tmp/gotools go install github.com/tomnomnom/unfurl@latest
    GOBIN=/tmp/gotools go install github.com/hakluke/hakcheckurl@latest
    GOBIN=/tmp/gotools go install github.com/tomnomnom/meg@latest
    # GOBIN=/tmp/gotools go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    GOBIN=/tmp/gotools go install github.com/tomnomnom/waybackurls@latest
    GOBIN=/tmp/gotools go install github.com/projectdiscovery/katana/cmd/katana@latest
    # GOBIN=/tmp/gotools go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    GOBIN=/tmp/gotools go install github.com/takshal/freq@latest
    GOBIN=/tmp/gotools go install github.com/j3ssie/sdlookup@latest
    GOBIN=/tmp/gotools go install -v github.com/hueristiq/xurlfind3r/cmd/xurlfind3r@latest
    GOBIN=/tmp/gotools go install github.com/ferreiraklet/airixss@latest
    GOBIN=/tmp/gotools go install github.com/ferreiraklet/nilo@latest
    # GOBIN=/tmp/gotools go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    GOBIN=/tmp/gotools go install github.com/lc/subjs@latest
    GOBIN=/tmp/gotools go install github.com/tomnomnom/qsreplace@latest
    GOBIN=/tmp/gotools go install github.com/hakluke/hakrawler@latest
    GOBIN=/tmp/gotools go install github.com/ThreatUnkown/jsubfinder@latest
    GOBIN=/tmp/gotools go install github.com/003random/getJS@latest
    GOBIN=/tmp/gotools go install github.com/gruntwork-io/git-xargs@latest
    GOBIN=/tmp/gotools go install github.com/lc/gau/v2/cmd/gau@latest
}

# Copy files to customize the ISO
cpmyfiles() {
    cp pacman.conf ./${ISONAME}/
    cp profiledef.sh ./${ISONAME}/
    cp packages.x86_64 ./${ISONAME}/
    cp -r grub/ ./${ISONAME}/
    cp -r efiboot/ ./${ISONAME}/
    cp -r syslinux/ ./${ISONAME}/
    cp -r etc/ ./${ISONAME}/airootfs/
    cp -r usr/ ./${ISONAME}/airootfs/
    cp /tmp/gotools/* ./${ISONAME}/airootfs/usr/local/bin/
}

# Set hostname
sethostname () {
    echo "${HSTNM}" > ./${ISONAME}/airootfs/etc/hostname
}

# Create passwd file
crtpasswd () {
echo "root:x:0:0:root:/root:/usr/bin/bash
"${USERNM}":x:1010:1010::/home/"${USERNM}":/bin/bash" > ./${ISONAME}/airootfs/etc/passwd
}

# Create group file
crtgroup () {
echo "root:x:0:root
sys:x:3:"${USERNM}"
adm:x:4:"${USERNM}"
wheel:x:10:"${USERNM}"
log:x:18:"${USERNM}"
network:x:90:"${USERNM}"
floppy:x:94:"${USERNM}"
scanner:x:96:"${USERNM}"
power:x:98:"${USERNM}"
uucp:x:810:"${USERNM}"
audio:x:820:"${USERNM}"
lp:x:830:"${USERNM}"
rfkill:x:840:"${USERNM}"
video:x:850:"${USERNM}"
storage:x:860:"${USERNM}"
optical:x:870:"${USERNM}"
sambashare:x:880:"${USERNM}"
users:x:985:"${USERNM}"
"${USERNM}":x:1010:" > ./${ISONAME}/airootfs/etc/group
}

# Create shadow file
crtshadow () {
    usr_hash=$(openssl passwd -6 "${USERPASSWD}")
    root_hash=$(openssl passwd -6 "${ROOTPASSWD}")
echo "root:"${root_hash}":14871::::::
"${USERNM}":"${usr_hash}":14871::::::" > ./${ISONAME}/airootfs/etc/shadow
}

# create gshadow file
crtgshadow () {
echo "root:!*::root
sys:!*::"${USERNM}"
adm:!*::"${USERNM}"
wheel:!*::"${USERNM}"
log:!*::"${USERNM}"
network:!*::"${USERNM}"
floppy:!*::"${USERNM}"
scanner:!*::"${USERNM}"
power:!*::"${USERNM}"
uucp:!*::"${USERNM}"
audio:!*::"${USERNM}"
lp:!*::"${USERNM}"
rfkill:!*::"${USERNM}"
video:!*::"${USERNM}"
storage:!*::"${USERNM}"
optical:!*::"${USERNM}"
sambashare:!*::"${USERNM}"
"${USERNM}":!*::" > ./${ISONAME}/airootfs/etc/gshadow
}

# Start mkarchiso
runmkarchiso () {
    mkarchiso -v -w ./work -o ./out ./${ISONAME}
}



rootuser
handlerror
preppacman
prepreqs
cleanup
cpreleng
rmunitsd
gotools
cpmyfiles
addnmlinks
sethostname
crtpasswd
crtgroup
crtshadow
crtgshadow
runmkarchiso
