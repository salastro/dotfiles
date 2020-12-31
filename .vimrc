syntax on

set nu
set rnu

set spelllang=en

autocmd BufWritePost *blocks.def.h !doas rm 'blocks.h' && doas make clean install && { killall -q dwmblocks;setsid dwmblocks & }
autocmd BufWritePost *config.def.h !doas rm 'config.h' && doas make clean install
autocmd BufWritePost *sxhkdrc !killall sxhkd; setsid sxhkd &
autocmd BufWritePost *.zshrc !exec zsh -l
autocmd BufNewFile,BufRead *.txt setlocal spell
