#!/bin/sh 

# options
read -p "Install bottom? (Y/n) " bottom
read -p "Install ytop? (Y/n) " ytop
read -p "Install dijo? (Y/n) " dijo
read -p "Install calcurse? (Y/n) " calcurse
read -p "Install newsboat? (Y/n) " newsboat
read -p "Install riceing progrms (ufetch/neofetch/cmatrix/libcaca)? (Y/n) " riceing
read -p "Install apulse? (Y/n) " apulse
read -p "Install fonts (font-awesome/font-symbola)? (Y/n) " fonts
read -p "Install compositor (picom)? (Y/n) " compositor
read -p "Install multimedia (ffmpeg/ImageMagick)? (Y/n) " multimedia
read -p "Install image viewr (sxiv)? (Y/n) " image_viewr
read -p "Install mpv? (Y/n) " mpv

# install
## update
sudo xbps-install -Syu 
sudo xbps-install -Syu 

# make essential dirs
mkdir ~/.config/
mkdir ~/.local/
mkdir ~/.local/bin/
mkdir ~/.srcpkgs/

## install dotfiles
### install git
sudo xbps-install -y git 
### clone dotfiles
git clone https://github.com/salahdin-ahmed/dotfiles.git

## instal doas
sudo xbps-install -y opendoas
### config
sudo cp dotfiles/.config/doas.conf /etc/doas.conf 

## shell
doas xbps-install -y zsh zsh-autosuggestions zsh-syntax-highlighting
### starship prompt
doas xbps-install -y starship
### config
cp dotfiles/.zshrc ~/.zshrc
cp dotfiles/.profile ~/.profile
cp dotfiles/.zprofile ~/.zprofile
cp dotfiles/.config/aliasrc ~/.config/aliasrc

## command-line programs
### neovim
doas xbps-install -y neovim
#### config
cp dotfiles/.vimrc ~/.vimrc 
cp -r dotfiles/.config/nvim ~/.config/nvim
##### plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

### nnn file manager
doas xbps-install -y nnn
#### config (plugins)
touch ~/.config/nnn/
cp -r dotfiles/.config/nnn/plugins ~/.config/nnn/plugins 

### system montier/process viewer
doas xbps-install -y htop
case $bottom in 
	"n") ;;
	*) doas xbps-install -y bottom ;;
esac
case $ytop in 
	"n") ;;
	*) doas xbps-install -y ytop ;;
esac

### productivity
#### termdown (timer)
doas xbps-install -y termdown

#### dijo (habit tracker)
_dijo() {
	doas xbps-install -y dijo
	##### config
	cp -r dotfiles/.config/dijo ~/.config/dijo
}
case $dijo in 
	"n") ;;
	*) _dijo ;;
esac

#### calcurse (calendar)
doas xbps-install calcurse

#### newsboat (RSS news feed)
doas xbps-install newsboat
##### config
cp -r dotfiles/.newsboat ~/.newsboat

_riceing() {
	## RICEing programs
	doas xbps-install ufetch cmatrix libcaca
	### neofetch
	doas xbps-install neofetch
	#### config
	cp -r dotfiles/.config/neofetch ~/.config/neofetch
}

## other
doas xbps-install -y wget fzf
### make
doas xbps-install -y make gcc

## audio/sound
doas xbps-install apulse

## graphical env
### Xorg
doas xbps-install -y xorg
#### config
cp dotfiles/.xinitrc ~/.xinitrc
#### numlockx
doas xbps-install -y numlockx
#### Keyboard
doas xbps-install -y xmodmap setxkbmap xkblayout-state
##### config
cp dotfiles/.Xmodmap ~/.Xmodmap
##### keybinds
doas xbps-install -y sxhkd
###### config
cp -r dotfiles/.config/sxhkd ~/.config/sxhkd/
#### screen/display
doas xbps-install -y brillo

#### window manager (dwm)
doas xbps-install -y libX11-devel libXinerama-devel libXft-devel fontconfig-devel
doas xbps-install font-awesome font-symbola
git clone https://github.com/salahdin-ahmed/dwm.git ~/.srcpkgs/dwm/
_compositor() {
	##### compositor
	doas xbps-install picom
	###### config
	cp -r dotfiles/.config/picom ~/.config/picom/
}
#### application luncher (dmenu)
git clone https://github.com/salahdin-ahmed/dmenu.git ~/.srcpkgs/dmenu/
#### status bar (dwmblocks)
git clone https://github.com/salahdin-ahmed/dwmblocks.git ~/.srcpkgs/dwmblocks/
#### terminal (st-luke-smith)
doas xbps-install -y ncurses-devel st-terminfo freetype-devel pkg-config harfbuzz-devel 
git clone https://github.com/LukeSmithxyz/st.git ~/.srcpkgs/st/
#### colorschemer
doas xbps-install -y pywal

#### additional tools
doas xbps-install -y xdotool xdo
doas xbps-install -y xwinwrap

#### multimedia
doas xbps-install ImageMagick ffmpeg
##### image viewr
doas xbps-install sxiv 
##### mpv
doas xbps-install mpv
###### config
cp -r dotfiles/.config/mpv ~/.config/mpv/

# cp important dirs
cp -r dotfiles/.scripts/ ~/.scripts/
cp -r dotfiles/.local/bin/status/ ~/.local/bin/
