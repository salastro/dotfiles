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

" automation
"" Suckless(-like) programs
autocmd BufWritePost *blocks.def.h !doas rm 'blocks.h' && doas make clean install && { pkill dwmblocks;setsid dwmblocks & }
autocmd BufWritePost *config.def.h !doas rm 'config.h' && doas make clean install
"" other
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
autocmd BufNewFile,BufRead *.txt setl spell
autocmd BufNewFile,BufRead *.tex setl spell
autocmd BufWritePost .Xmodmap !setxkbmap && xmodmap ~/.Xmodmap

" templates
"" html
nnoremap 'html :-read ~/.config/nvim/skeletons/skeleton.html<CR>:filetype detect<CR>7j9li
autocmd FileType html inoremap ;h <h1></h1><!----><Esc>FhT>i
autocmd FileType html inoremap ;p <p></p><!----><Esc>FpT>i
autocmd FileType html inoremap <Space><Space> <Esc> /<!----><CR>"_c7l
autocmd FileType html nnoremap <Space><Space> <Esc> /<!----><CR>"_d7l

" file type detect
nnoremap ftd :filetype detect<CR>
" update configuration
nnoremap ,uc :so ~/.config/nvim/init.vim<CR>

" tag jumping
com! MakeTags !ctags -R .

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'christoomey/vim-titlecase' 
" Plug 'djoshea/vim-autoread'
Plug 'baskerville/vim-sxhkdrc'
Plug 'christoomey/vim-sort-motion'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/AutoComplPop'
Plug 'vimwiki/vimwiki'

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
