#!/bin/bash

sudo pacman -S --noconfirm --needed devtools

CHROOT="${HOME}"/Documents/chroot
mkdir -p "${CHROOT}"
mkarchroot "${CHROOT}"/root base-devel
arch-nspawn "${CHROOT}"/root pacman -Syu

for i in $(/bin/ls PkgBuilds); do
    echo "Building $i"
    cd PkgBuilds/$i || exit
    makechrootpkg -c -r "${CHROOT}"
    mv *.pkg.tar.zst ../..
    cd ../../ || exit
    echo $i
done

for i in $(cat repos ); do
    if [[ ${i:0:1} != "#" ]]; then
        pkgname=$(echo $i | cut -d "/" -f 4 | sed 's|\.git||')
        git clone $i
        if [[ ! -d "${pkgname}" ]]; then
            pkgname=$(echo $i | cut -d "/" -f 5 | sed 's|\.git||')
        fi
        cd "${pkgname}" || exit
        if [[ "${pkgname}" == "betterlockscreen" ]];then
            rm ../i3lock-color-debug*
            cp ../i3lock-color* ./i3lock-color.pkg.tar.zst
            makechrootpkg -I i3lock-color.pkg.tar.zst -r "${CHROOT}"
            rm i3lock-color.pkg.tar.zst
        else 
            makechrootpkg -c -r "${CHROOT}"
        fi
        mv *.pkg.tar.zst ..
        cd ../ || exit
        rm -rf "${pkgname}"
    fi
done

sudo rm -rf "${CHROOT}"
repo-add custom.db.tar.gz *.pkg.tar.zst
