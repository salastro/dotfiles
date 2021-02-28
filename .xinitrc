#!/bin/sh
setxkbmap -layout us,ara -option grp:alt_space_toggle
xmodmap ~/.config/Xmodmap
# doas kmonad ~/.config/kmonad-test.kbd &
numlockx &

~/.cache/background

sxhkd &
picom --experimental-backends &
dwmblocks &

$TERMINAL calcurse &
$TERMINAL dijo &

dwm
