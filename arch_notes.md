# Notes for installing Arch

## Packages

Packages can be installed from the provided `pkglist.txt` with `$ sudo pacman -S --needed - < pkglist.txt`. This list can be generated a maintained with `$ pacman -Qqe > pkglist.txt`. For more information, see [the guide on the Arch wiki](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages).

### Pacstrap

```sh
# pacstrap /mnt base linux linux-lts linux-firmware base-devel intel-ucode gvim
```

## Configuring `systemd-boot`

IMPORTANT: `systemd-boot` does not accept tabs for indentation, use spaces instead.

* Enable automatic updates with `systemd`: `$ sudo systemctl enable --now systemd-boot-update.service` after reboot
* Make sure to install `intel-ucode` (or AMD equivalent)
* The options part in the entries can be filled in with the below command. Make sure to substitute `dev/sdX` with the root partition (`/`)

```sh
$ echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/sdaX) rw" >> /boot/loader/entries/arch.conf
```

## Hostname

```sh
$ sudo vim /etc/hostname
arch # this will be the hostname, i.e., [user@arch ~]
```

```sh
$ sudo vim /etc/hosts
127.0.0.1       localhost
::1             localhost
127.0.1.1       arch
```

## Add new user

```sh
$ sudo EDITOR=vim visudo
# Uncomment %wheel ALL=(ALL:ALL) ALL

# Add new user with <name>. '/bin/bash' can be substituted for '/bin/zsh' if installed
$ useradd -m -G wheel -s /bin/bash <name>
$ passwd <name>
```

## Audio

This is easily handled using Pipewire

```sh
$ sudo pacman -S pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber
$ systemctl --user enable --now pipewire-pulse.service
```

## Network with wired connection

### Using `NetworkManager`:

```sh
$ sudo pacman -S networkmanager network-manager-applet
$ sudo systemctl enable --now NetworkManager.service
```

### Using `systemd-networkd`:

For the hostname to be resolved, `polkit` must be installed!

1. Edit `etc/systemd/network/20-wired.network`

```sh
[Match]
Name=en* # Confirm adapter name with `$ ip a`

[Network]
DHCP=yes
```

2. From outside chroot:

```sh
$ ln -rsf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

3. Enable the systemd services:

```sh
$ sudo systemctl enable --now systemd-networkd
$ sudo systemctl enable --now systemd-resolved
```

## Tips

* Enable trim for SSD/NVMe dsisk: `$ sudo systemctl enable --now fstrim.timer`. Enabling this timer, will activate the service weekly
* [Pacman commands compared to other package managers](https://wiki.archlinux.org/title/Pacman/Rosetta)
* Increase verbosity of `pacman`
```sh
$ nvim /etc/pacman.conf

# Misc options
#UseSysLog
Color
#NoProgressBar
CheckSpace
VerbosePkgLists
ParallelDownloads = 5
ILoveCandy
```
* Starting your WM, e.g., `exec bspwm` or `exec i3`, must be the last part of the `.xinitrc`. This is important!
* When using `feh` to set the background (`$ feh --bg-scale --no-fehbg /path/to/image.jpg`), do it after the monitor configuration to ensure correct scaling. Notice the `--no-fehbg` option to avoid the `~/.fehbg` script
* Remap caps lock to escape: `$ setxkbmap -option caps:escape` (`setxkbmap` should be installed with the `xorg` package)
* Keybinding to switch keyboard layout: `setxkbmap -option grp:win_space_toggle us,dk`. For available key combinations, check the output of: `grep "grp:.*toggle" /usr/share/X11/xkb/rules/base.lst`
* To check for firmware updates: `$ sudo pacman -S fwupd` and check on ArchWiki how to use it
* If you need more disk space, you can clear the Pacman cache with `$ sudo paccache -r`. Note that this program comes with the package `pacman-contrib`. This can also be configured as a Pacman hook
* Check for packages that are no longer needed as dependencies: `$ pacman -Qtdq` or remove them with `$ pacman -Rns $(pacman -Qtdq)`
* To get precise colors of applications (both GUI and TUI), install and run `xcolor`

