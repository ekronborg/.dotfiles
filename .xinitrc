#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Gnome-keyring
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# Set monitor output
xrandr --output DP-2 --primary --mode 2560x1440 --rate 144 --rotate normal --output DP-0 --mode 1920x1080 --rate 60 --rotate normal --left-of DP-2 &

# Set background
feh --bg-scale --no-fehbg $HOME/Pictures/wallpapers/1.png &

# Remap escape to caps lock
# setxkbmap -option caps:escape

# Switch keyboard layout with super+space
setxkbmap -option grp:win_space_toggle us,dk

# Start programs
dunst &
exec bspwm
