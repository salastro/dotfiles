set autoread

syntax on

set nu
set rnu

set spelllang=en

autocmd BufWritePost *blocks.def.h !doas rm 'blocks.h' && doas make clean install && { pkill dwmblocks;setsid dwmblocks & }
autocmd BufWritePost *config.def.h !doas rm 'config.h' && doas make clean install
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
autocmd BufWritePost *.zshrc !exec zsh -l
autocmd BufNewFile,BufRead *.txt setlocal spell

call plug#begin('~/.local/share/nvim/plugged')
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()
