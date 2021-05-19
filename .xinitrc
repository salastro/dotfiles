#!/bin/sh

# Keyboard
setxkbmap -layout us,ara -option compose:lctrl -option grp:alt_space_toggle
numlockx &

# Themes stuff
xrdb ~/.Xresources
xrdb -merge ~/.cache/wal/colors.Xresources
~/.cache/background

# Background stuff
sxhkd &
picom --experimental-backends &
dwmblocks &

# the WM/DE
exec dwm
