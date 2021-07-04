# .zsh_profile
# important paths
path+=('/home/salahdin/.local/bin/status')
path+=('/home/salahdin/.scripts')

# source profile if there
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

# auto connect wifi
#pgrep wpa_supplicant || doas wpa_supplicant -B -i wlo1 -c /etc/wpa_supplicant/wpa_supplicant-wlo1.conf

# if login in tty1 (basically the first tty to open) then
if [[ "$(tty)" = "/dev/tty1" ]]; then
       # check if chronyd is working and if not start it (for some reason this fixes time)
	pgrep chronyd || doas chronyd
       # check dwm is working and if not startx
        pgrep dwm || { neofetch --config .config/neofetch/config-start-up.conf ; sx} 
fi
