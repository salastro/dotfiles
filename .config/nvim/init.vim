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
autocmd BufNewFile,BufRead COMMIT_EDITMSG setl spell
"" other
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
autocmd BufWritePost *.kbd !doas pkill kmonad; setsid doas kmonad %:p &

" templates
"" roff
nnoremap 'roff :-read ~/.config/nvim/skeletons/skeleton.ms<CR>:filetype detect<CR>

" file type detect
nnoremap ftd :filetype detect<CR>
" update configuration
nnoremap ;uc :so ~/.config/nvim/init.vim<CR>

" functions

" Custom commands
"" tag jumping
com! MakeTags !ctags -R .
"" Compiler
com! Compile !compiler %
"" Sent prsentations
com! Sent !sent-pywal-theme % &

call plug#begin('~/.local/share/nvim/plugged')

" git wrapper
Plug 'tpope/vim-fugitive'

" motions
Plug 'christoomey/vim-sort-motion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-titlecase' 

" themes
Plug 'chrisbra/Colorizer'
Plug 'itchyny/lightline.vim'
" Plug 'morhetz/gruvbox'

" syntax highlighting
Plug 'baskerville/vim-sxhkdrc'
Plug 'cespare/vim-toml'
Plug 'farfanoide/vim-kivy'
Plug 'kmonad/kmonad-vim'

" external programs
Plug 'ActivityWatch/aw-watcher-vim'
Plug 'mcchrish/nnn.vim'

" other
Plug 'junegunn/goyo.vim'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8' }
Plug 'vim-scripts/AutoComplPop'
Plug 'vimwiki/vimwiki'

call plug#end()

" VimWiki
let g:vimwiki_list = [{'path': '~/Documents/VimWiki/',
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

" Emmet
let g:user_emmet_leader_key = '<C-e>'

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" NNN
nnoremap <leader>n :NnnPicker %:p:h<CR>
let g:nnn#layout = 'vnew'
let g:nnn#layout = { 'left': '~20%' }
let g:nnn#set_default_mappings = 1
let g:nnn#command = 'nnn -r -C -e -t 120'
let $NNN_LOCKER="/usr/local/bin/pipes.sh"
let $NNN_PLUG='f:simple-fzf-open;w:setpywal;W:setpywalvid;d:dragdrop;t:preview-tabbed;i:-sxiv;I:d-sxiv'
let $NNN_BMS='D:~/Documents;d:~/Downloads;p:~/Pictures;v:~/Videos;m:~/Music;P:~/.srcpkgs;S:~/.scripts;a:~/.local/bin;s:/mnt/DiskE/Important/STEM;c:~/.config/;M:/media/'
let $NNN_FIFO="/tmp/nnn.fifo"
let $NNN_TRASH=1

" Titlecase
let g:titlecase_map_keys = 0
nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
nmap <leader>gT <Plug>TitlecaseLine

" Startify
let g:startify_bookmarks = [
			\ {'c': '~/.config/nvim/init.vim'},
			\ {'d': '~/.srcpkgs/dwm/config.def.h'},
			\ {'s':'~/.config/sxhkd/sxhkdrc'},
			\ {'u': '~/.config/qutebrowser/config.py'},
			\ {'a':'~/.config/aliasrc'},
			\ {'ww':'~/Documents/VimWiki/index.md'},
			\ {'wi':'~/Documents/VimWiki/diary/diary.md'},
			\ ]
let g:startify_lists = [
			\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
			\ { 'type': 'files',     'header': ['   MRU']            },
			\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
			\ { 'type': 'sessions',  'header': ['   Sessions']       },
			\ { 'type': 'commands',  'header': ['   Commands']       },
			\ ]
map <leader>S :Startify<CR>

" RT-Format
let g:rtf_ctrl_enter = 0
let g:rtf_on_insert_leave = 1

" Colorizer
let g:colorizer_auto_color = 1

" colorscheme gruvbox
" let g:gruvbox_transparent_bg = 1
