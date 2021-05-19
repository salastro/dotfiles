#!/bin/sh

# Keyboard
setxkbmap -layout us,ara -option compose:lctrl -option grp:alt_space_toggle
numlockx &

# Themes stuff
~/.cache/background

# Background stuff
sxhkd &
picom --experimental-backends &
dwmblocks &

# the WM/DE
exec dwm
