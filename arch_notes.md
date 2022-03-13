# Notes for installing Arch

## Packages

```sh
$ sudo pacman -S xorg xorg-xinit i3-gaps i3status dmenu firefox alacritty feh \
ttf-jetbrains-mono exa ttf-font-awesome bat ripgrep fd
```

## Configuring `systemd-boot`

*   Enable automatic updates with `systemd`: `$ sudo systemctl enable --now systemd-boot-update.service`
*   Make sure to install `intel-ucode` (or AMD equivalent)
*   The options part in the entries can be filled in with the below command. Make sure to substitute `dev/sdX` with the `esp` (UEFI System Partition aka `/boot`)

```sh
$ echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/sdaX rw >> /boot/loader/entries/arch.conf
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
127.0.1.1       arch.localdomain    arch
```

## Network with wired connection

Using `NetworkManager`:

```sh
$ sudo pacman -S networkmanager network-manager-applet
$ sudo systemctl enable --now NetworkManager.service
```

Using `systemd-networkd`:

1.  Edit `etc/systemd/network/20-wired.network`

```sh
[Match]
Name=en* # Confirm adapter name with `$ ip a`

[Network]
DHCP=yes
```

2.  From outside chroot:

```sh
$ ln -rsf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

3.  Enable the systemd services:

```sh
$ sudo systemctl enable --now systemd-networkd
$ sudo systemctl enable --now systemd-resolved
```

## Tips

* `i3lock` doesn't have a password prompt, so just start typing your password. It can also be launched with a background (`i3lock -i /path/to/image.jpg`) or a solid color (`i3lock -c 282828`)
* Enable colored output of pacman commands by uncommenting `Color` in `/etc/pacman.conf`
* Enable trim for SSD/NVMe dsisk: `sudo systemctl enable --now fstrim.timer`. Enabling this timer, will activate the service weekly

### `.xinitrc`

*   Start i3 automatically when `startx` is launched: `exec i3`. ***Important:*** this must be the last part of the `.xinitrc` file!
*   Monitor configuration with `xrandr` goes in here as well. For example, `xrandr --output DP-1 --mode 2560x1440 --rate 144`
*   Use `feh` to set a background: `feh --bg-scale /path/to/image.jpg`. Put this option *after* the monitor configuration to ensure correct scaling
*   Remap caps lock to escape: `setxkbmap -option caps:escape` (`setxkbmap` should be installed with the `xorg` package)

