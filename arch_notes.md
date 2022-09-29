# Notes for installing Arch

## Packages

Packages can also be installed from a list: `$ sudo pacman -S --needed - < pkglist.txt`. This list can be generated a maintained with `$ pacman -Qqe > pkglist.txt`. For more information, see [the guide on the Arch wiki](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages).

```sh
$ sudo pacman -S xorg xorg-xinit bspwm sxhkd polybar dunst firefox alacritty feh rofi fzf \
ttf-jetbrains-mono exa bat ripgrep fd arc-icon-theme papirus-icon-theme zsh zsh-completions \
tmux git neovim polkit sof-firmware curl openssh neofetch nvidia nvidia-lts nvidia-settings reflector \
xclip ffmpeg noto-fonts-cjk noto-fonts-extra noto-fonts-emoji pacman-contrib libva-vdpau-driver \
pipewire pipewire-alsa pipewire-jack pipewire-pulse man-pages
```

```sh
$ yay -S ttf-font-awesome-5 terminus-font-ll2-td1 nerd-fonts-jetbrains-mono
```

### Pacstrap

```sh
# pacstrap base linux linux-lts linux-firmware base-devel intel-ucode gvim
```

## Configuring `systemd-boot`

* Enable automatic updates with `systemd`: `$ sudo systemctl enable --now systemd-boot-update.service`
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
# Uncomment %wheel ALL=(ALL) ALL

# Add new user with <name>. '/bin/bash' can be substituted for '/bin/zsh' if installed
$ useradd -m -G wheel -s /bin/bash <name>
$ passwd <name>
```

## Network with wired connection

### Using `NetworkManager`:

```sh
$ sudo pacman -S networkmanager network-manager-applet
$ sudo systemctl enable --now NetworkManager.service
```

### Using `systemd-networkd`:

For the hostname to be resolved, `polkit` must be installed!

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

* `i3lock` doesn't have a password prompt, so just start typing your password. It can also be launched with a background (`$ i3lock -i /path/to/image.jpg`) or a solid color (`$ i3lock -c 282828`)
* Enable colored output of pacman commands by uncommenting `Color` in `/etc/pacman.conf`
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

* Set up a Pacman hook to keep an up-to-date list of explicitly installed packages, see [this link](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages). Point `pkglist.txt` to a Git repo to have it under version control as well
* Starting your WM, e.g., `exec bspwm` or `exec i3`, must be the last part of the `.xinitrc`. This is important!
* When using `feh` to set the background (`$ feh --bg-scale --no-fehbg /path/to/image.jpg`), do it after the monitor configuration to ensure correct scaling
* Remap caps lock to escape: `$ setxkbmap -option caps:escape` (`setxkbmap` should be installed with the `xorg` package)
* Keybinding to switch keyboard layout: `setxkbmap -option grp:win_space_toggle us,dk`. For available key combinations, check the output of: `grep "grp:.*toggle" /usr/share/X11/xkb/rules/base.lst`
* To check for firmware updates: `$ sudo pacman -S fwupd` and check on ArchWiki how to use it
* If you need more disk space, you can clear the Pacman cache with `$ sudo paccache -r`. Note that this program comes with the package `pacman-contrib`
* Check for packages that are no longer needed as dependencies: `$ pacman -Qtdq` or remove them with `$ pacman -Rns $(pacman -Qtdq)`
* To get precise colors of applications (both GUI and TUI), install and run `xcolor`

