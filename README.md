<img src="https://raw.githubusercontent.com/h41stur/m0n4rch/main/etc/calamares/branding/m0n4rch/logo.png" alt="M0n4rch" width="400" align="center" />

# M0n4rch Linux

M0n4rch Linux is a complete desktop based on Arch Linux using the LTS kernel. It is configured to use BSPWM and KDE Plasma desktops.

As a long-time Arch Linux user and offensive security professional, I decided to start this project to create a ready-made distribution with the same settings I usually use on a day-to-day basis.

However, the biggest motivation for this project was the possibility of studying and deepening my knowledge of Linux.

This project is released under the GPL open source license and demonstrates one possible method for constructing an Arch Linux based system. The files are free to use and modify. Please keep the author attribution intact when utilizing this project.

**User password**: m0n4rch  
**Root password**: toor


## Building

To build the ISO image, it is recommended that it be done from Arch Linux so that specific tools can be used.

### AUR Packages

As AUR packages are not part of the official manager, you need to create a local repository where they will be ready to be installed when building the ISO.

The local repository is mounted in the `custom` directory in the project root.

All package AUR repository URLs are contained in the `repos` file.

Still within the `custom` directory there is the `PkgBuilds` folder which contains some essential packages for the functioning of **Calamares** and which have been changed from the original.

The `compile.sh` script uses `chroot` to create a package compilation environment using `mkarchroot` and `makechrootpkg`.

After the appropriate changes and execution of the script, all packages will be ready in the `custom` directory.

It is extremely important that the `pacman.conf` file existing in the project root directory is **updated** to import the local repository. It should look like this:

```
[custom]
SigLevel = Optional TrustAll
Server = file:///path/to/custom
```

### Build

To build the ISO, the `setup.sh` script at the root of the project will do the automated step-by-step process. It is important to check the need to change some variables configured at the beginning of the script:

```bash
ISONAME="m0n4rch"
USERNM="m0n4rch"
USERPASSWD="m0n4rch"
ROOTPASSWD="toor"
HSTNM="m0n4rch"
```

If you want to leave it as default, the script must be run as `root`.

```bash
sudo ./setup.sh
```

At the end of the process, an ISO file will be generated in the `out/` directory that will load a live environment that uses BSPWM by default.

When logging into the live environment session, a script will automatically update the `keyring` and `mirrors` of `pacman` and then `Calamares` will be executed to begin the installation.

## Disclaimer

All of my scripts and documents are free for public use and adaptation, as per the terms as licensed under the GNU Public License 3.0. Please use and enjoy.
