#!/bin/sh

setxkbmap -layout us,ara -option compose:lctrl -option grp:alt_space_toggle
numlockx &

~/.cache/background

sxhkd &
picom --experimental-backends &
dwmblocks &

exec dwm
