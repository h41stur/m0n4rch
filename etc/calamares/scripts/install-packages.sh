#!/bin/bash

#for package in $(cat /etc/calamares/scripts/packages);do
#    pacman -S --noconfirm $package
#done

# Python Packages
git clone https://github.com/guelfoweb/knock.git /opt/knock
pip3 install -r /opt/knock/requirements.txt --break-system-packages

git clone https://github.com/s0md3v/Photon.git /opt/Photon
pip3 install -r /opt/Photon/requirements.txt --break-system-packages

git clone --recursive https://github.com/screetsec/Sudomy.git /opt/Sudomy
pip3 install -r /opt/Sudomy/requirements.txt --break-system-packages

pip3 install uro --break-system-packages

git clone https://github.com/0x240x23elu/JSScanner.git /opt/JSScanner
pip3 install -r /opt/JSScanner/requirements.txt --break-system-packages

git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git /opt/xnLinkFinder
pip3 install -r /opt/xnLinkFinder/requirements.txt --break-system-packages

git clone https://github.com/ticarpi/jwt_tool.git /opt/jwt_tool
pip3 install -r /opt/jwt_tool/requirements.txt --break-system-packages

git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap-dev

git clone https://gitlab.com/exploit-database/exploitdb.git /opt/exploitdb
ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit

pip3 install aort --break-system-packages
