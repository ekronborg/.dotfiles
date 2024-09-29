https://github.com/swaywm/sway/wiki/i3-Migration-Guide

https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland

https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway

https://swayos.github.io/

https://wiki.hyprland.org/Useful-Utilities/Status-Bars/

https://github.com/valebes/nix-dotfiles?tab=readme-ov-file

The author of `grim`, `slurp`, and `kanshi` has also made other tools specifically for Wayland, see
https://wayland.emersion.fr/ . He is a maintainer for `wlroots` and `sway`, so his software is probably of decent
quality.

`waybar` needs `noto-fonts-emoji ` to display flags in the `sway/language` module.

- `dunst` is supported on Wayland by default
- Screenshots via `grim` + `slurp`
- `rofi` can be substituted with `rofi-wayland` or `fuzzel`. Note that `wofi` is not maintained.
- `polybar` can be substituted with `waybar` or `yambar` for a lightweight alternative
- `sov` (AUR) can be used for an overview of workspaces: https://github.com/milgra/sov

```bash
$ sudo pacman -S \
    sway \
    swaylock \
    swayidle \
    swaybg \
    autotiling \
    waybar \
    dunst \
    libnotify \
    papirus-icon-theme \
    rofi-wayland \
    grim \
    slurp \
    swappy \
    pop-gtk-theme \
    pavucontrol \
    wl-clipboard \
    kanshi \
    brightnessctl \
    gammastep
```
