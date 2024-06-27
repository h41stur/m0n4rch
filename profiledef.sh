#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="m0n4rchos"
iso_label="M0N4RCHOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="M0n4rch OS <https://h41stur.com>"
iso_application="M0n4rch OS Live/Rescue DVD"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.systemd-boot.esp' 'uefi-x64.systemd-boot.esp'
           'uefi-ia32.systemd-boot.eltorito' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/etc/sudoers"]="0:0:400"
  ["/etc/m0sudoers"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/"]="0:0:755"
  ["/etc/skel/.config/"]="1000:1000:755"
  ["/etc/skel/.local/bin/"]="1000:1000:755"
  ["/etc/skel/.xinitrc"]="1000:1000:755"
  ["/etc/skel/.fehbg"]="1000:1000:755"
  ["/etc/skel/.config/bspwm/bin/"]="1000:1000:755"
)
