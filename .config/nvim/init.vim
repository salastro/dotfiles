"  _   _         __     ___           
" | \ | | ___  __\ \   / (_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
" | |\  |  __/ (_) \ V / | | | | | | |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|

" Lines numbering
se nu
se rnu

" Completions
se cpt+=kspell
se cot=menuone

" Enable mouse
se mouse=a

" vars

" keys
vnoremap  "+y:%s/\V"/
vnoremap  "+y/\V"
nnoremap  z=

let mapleader = " "

" automation
"" Suckless(-like) programs
autocmd BufWritePost *blocks.def.h !doas rm 'blocks.h' && doas make clean install && { pkill dwmblocks;setsid dwmblocks & }
autocmd BufWritePost *config.def.h !doas rm 'config.h' && doas make clean install
"" spell
autocmd BufNewFile,BufRead *.txt setl spell
autocmd BufNewFile,BufRead *.tex setl spell
autocmd BufNewFile,BufRead *.ms setl spell
autocmd BufNewFile,BufRead *.md setl spell
"" other
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
autocmd BufWritePost *.kbd !doas pkill kmonad; setsid doas kmonad %:p &

" templates
"" roff
nnoremap 'roff :-read ~/.config/nvim/skeletons/skeleton.ms<CR>:filetype detect<CR>

" file type detect
nnoremap ftd :filetype detect<CR>
" update configuration
nnoremap ,uc :so ~/.config/nvim/init.vim<CR>

" functions

" Custom commands
"" tag jumping
com! MakeTags !ctags -R .
"" Compiler
com! Compile !compiler %

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'christoomey/vim-titlecase' 
" Plug 'djoshea/vim-autoread'
Plug 'baskerville/vim-sxhkdrc'
Plug 'kmonad/kmonad-vim'
Plug 'cespare/vim-toml'
Plug 'christoomey/vim-sort-motion'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'skywind3000/vim-rt-format'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/AutoComplPop'
Plug 'vimwiki/vimwiki'
Plug 'skammer/vim-css-color'

call plug#end()

" VimWiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Goyo
function! s:goyo_enter()
	norm zz
	nnoremap j gjzz
	nnoremap k gkzz
	nnoremap w wzz
	nnoremap b bzz
endfunction

function! s:goyo_leave()
	nnoremap j j
	nnoremap k k
	nnoremap w w
	nnoremap b b
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
