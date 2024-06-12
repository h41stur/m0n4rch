#!/bin/bash


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
    pkgname=$(echo $i | cut -d "/" -f 4 | sed 's|\.git||')
    git clone $i
    if [[ ! -d "${pkgname}" ]]; then
        pkgname=$(echo $i | cut -d "/" -f 5 | sed 's|\.git||')
    fi
    cd "${pkgname}" || exit
    makechrootpkg -c -r "${CHROOT}"
    mv *.pkg.tar.zst ..
    cd ../ || exit
    rm -rf "${pkgname}"
done

sudo rm -rf "${CHROOT}"
repo-add custom.db.tar.gz *.pkg.tar.zst
