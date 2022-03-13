#!/bin/bash

# Take screenshot
scrot -m '/tmp/lock.png'

# Use ImageMagick to add blur
convert /tmp/lock.png -blur 0x9 /tmp/lock.png

# Start i3lock with background image
i3lock -i /tmp/lock.png

# Delete screenshot
rm /tmp/lock.png
