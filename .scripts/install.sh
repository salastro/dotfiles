#!/bin/sh 

# install
## update
sudo xbps-install -Su 
sudo xbps-install -Su 

# make essential dirs
mkdir ~/.config/
mkdir ~/.local/
mkdir ~/.local/bin/
mkdir ~/.srcpkgs/

## install dotfiles
### install git
sudo xbps-install git 
### clone dotfiles
git clone https://github.com/salahdin-ahmed/dotfiles.git

## instal doas
sudo xbps-install opendoas
### config
sudo cp dotfiles/.config/doas.conf /etc/doas.conf 

## shell
doas xbps-install zsh
doas xbps-install zsh-autosuggestions
doas xbps-install zsh-syntax-highlighting
### starship prompt
doas xbps-install starship
### config
cp dotfiles/.zshrc ~/.zshrc
cp dotfiles/.profile ~/.profile
cp dotfiles/.zprofile ~/.zprofile
cp dotfiles/.config/aliasrc ~/.config/aliasrc

## terminal programs
### neovim
doas xbps-install neovim
#### config
cp dotfiles/.vimrc ~/.vimrc 
cp -r dotfiles/.config/nvim ~/.config/nvim

### nnn file manager
doas xbps-install nnn
#### config (plugins)
cp -r dotfiles/.config/nnn/plugins ~/.config/nnn/plugins 

### system montier/process viewer
doas xbps-install bottom
doas xbps-install ytop

### productivity
#### termdown (timer)
doas xbps-install termdown

#### dijo (habit tracker)
doas xbps-install dijo
##### config
cp -r dotfiles/.config/dijo ~/.config/dijo

#### calcurse (calendar)
doas xbps-install calcurse

#### newsboat (RSS news feed)
doas xbps-install newsboat
##### config
cp -r dotfiles/.newsboat ~/.newsboat

## RICEing programs
doas xbps-install ufetch cmatrix libcaca
### neofetch
doas xbps-install neofetch
#### config
cp -r dotfiles/.config/neofetch ~/.config/neofetch

## other
### make
doas xbps-install make gcc

## audio/sound
doas xbps-install apulse

## graphical env
### Xorg
doas xbps-install xorg
#### config
cp dotfiles/.xinitrc ~/.xinitrc
#### numlockx
doas xbps-install numlockx
#### Keyboard
doas xbps-install xmodmap setxkbmap xkblayout-state
##### keybinds
doas xbps-install sxhkd
###### config
cp -r dotfiles/.config/sxhkd ~/.config/sxhkd/
#### screen/display
doas xbps-install brillo

#### window manager (dwm)
doas xbps-install libX11-devel libXinerama-devel libXft-devel fontconfig-devel
git clone https://github.com/salahdin-ahmed/dwm.git ~/.srcpkgs/dwm/
##### compositor
doas xbps-install picom
###### config
cp -r dotfiles/.config/picom ~/.config/picom/
#### application luncher (dmenu)
git clone https://github.com/salahdin-ahmed/dmenu.git ~/.srcpkgs/dmenu/
#### status bar (dwmblocks)
git clone https://github.com/salahdin-ahmed/dwmblocks.git ~/.srcpkgs/dwmblocks/
#### terminal (st-luke-smith)
doas xbps-install ncurses-devel st-terminfo freetype-devel pkg-config
git clone https://github.com/LukeSmithxyz/st.git ~/.srcpkgs/st/
#### colorschemer
doas xbps-install pywal

#### additional tools
doas xbps-install xdotool xdo xwinwrap

#### multimedia
doas xbps-install ImageMagick sxiv ffmpeg
##### mpv
doas xbps-install mpv
###### config
cp -r dotfiles/.config/mpv ~/.config/mpv/

# cp important dirs
cp -r dotfiles/.scripts/ ~/.scripts/
cp -r dotfiles/.local/bin/status/ ~/.local/bin/
