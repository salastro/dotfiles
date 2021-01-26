syntax on

set nu
set rnu

set spl=en

set cpt+=kspell
set cot=menuone,longest

autocmd BufWritePost *blocks.def.h !doas rm 'blocks.h' && doas make clean install && { pkill dwmblocks;setsid dwmblocks & }
autocmd BufWritePost *config.def.h !doas rm 'config.h' && doas make clean install
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
autocmd BufNewFile,BufRead *.txt setlocal spell

call plug#begin('~/.local/share/nvim/plugged')
" Nerdtree things "
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Auto Complete PopUp "
Plug 'vim-scripts/AutoComplPop'
call plug#end()
