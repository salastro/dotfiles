"  _   _         __     ___           
" | \ | | ___  __\ \   / (_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
" | |\  |  __/ (_) \ V / | | | | | | |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|
"
"

" Lines numbering
se nu
se rnu

" line breaks wraping
se wrap 
se linebreak

" completions
se cpt+=kspell,t
se cot=menu,menuone,noselect
se icm=nosplit
se wim=longest:full,full
se wmnu
se ofu=syntaxcomplete#Complete

" cursor lines
se cursorline
se cursorcolumn

" Enable mouse
se mouse=a

se title
se ic
" se scs

" keys
let mapleader = " "

" tabs
nnoremap H gT
nnoremap L gt
nnoremap T :tabnew<CR>
au TabLeave * let g:lasttab = tabpagenr()
nnoremap  :exe "tabn ".g:lasttab<cr>

" search
vnoremap  "+y:%s/\V"/
vnoremap  "+y/\V"

noremap ; :
noremap : ;

vnoremap  "+y

se fdm=marker

function! MoveEm(position)
  let saved_cursor = getpos(".")
  let previous_blank_line = search('^$', 'bn')
  let target_line = previous_blank_line + a:position - 1
  execute 'move ' . target_line
  call setpos('.', saved_cursor)
endfunction

for position in range(1, 9)
  execute 'nnoremap m' . position . ' :call MoveEm(' . position . ')<cr>'
endfor

function! MarkHead(level)
	normal! mm
	execute ':normal! ' . a:level . 'I#a `m' . a:level . 'll'
endfunction

fun! MarkRange()
	for level in range(1, 9)
		execute 'nnoremap <leader>h' . level . ' :call MarkHead(' . level . ')<cr>'
	endfor
endf

fun MarkLink()
	nnoremap <leader>pp a[mma](+)`ma
endf

" spell keys
nnoremap  1z=
nnoremap <leader>ps :normal! mm[s1z=`m<cr>
nnoremap <leader>ns :normal! mm]s1z=`m<cr>

nnoremap <leader>mc :!ctags -R .<cr>

nnoremap <leader><leader> za

" automation
"" Suckless programs
au BufWritePost *blocks.def.h !doas rm 'blocks.h' && doas make clean install && { pkill dwmblocks;setsid dwmblocks & }
au BufWritePost *config.def.h !doas rm 'config.h' && doas make clean install
"" spell
au FileType text setl spell
au FileType tex setl spell
au FileType markdown setl spell
au FileType markdown call  MarkRange()
au FileType markdown call  MarkLink()
au FileType gitcommit setl spell
"" other
au BufWritePost *sxhkdrc !pkill -USR1 sxhkd
au BufWritePost *.kbd !pkill kmonad; setsid kmonad %:p &
au BufEnter *.py :RTFormatEnable
" au FileType python setl fdm=indent
au BufEnter *.js :RTFormatEnable
au FileType cpp setl fdm=syntax

" templates
"" roff
nnoremap 'roff :-read ~/.config/nvim/skeletons/skeleton.ms<CR>:filetype detect<CR>

" file type detect
nnoremap ftd :filetype detect<CR>
" update configuration
nnoremap cu :so ~/.config/nvim/init.vim<CR>

" functions

" Custom commands
"" Compiler
com! Compile !compiler %
"" Sent prsentations
com! Sent !sent-pywal-theme % &

com! PlugAdd normal oPlug '+'dF.F/F/vT'd

ca h  tab help
ca hv vert help
ca hh help

command! -nargs=0 Sw w !doas tee % > /dev/null

call plug#begin('~/.local/share/nvim/plugged')

" motions
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-titlecase' 
Plug 'easymotion/vim-easymotion'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'matze/vim-move'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Completions
Plug 'DougBeney/pickachu'
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'f3fora/cmp-spell'
Plug 'folke/which-key.nvim'
Plug 'honza/vim-snippets'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'nixon/vim-vmath'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'rhysd/vim-grammarous'
" Plug 'skywind3000/vim-auto-popmenu'
Plug 'jdhao/better-escape.vim'

" themes
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" syntax highlighting
Plug 'andymass/vim-matchup'
Plug 'baskerville/vim-sxhkdrc'
Plug 'cespare/vim-toml'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'kmonad/kmonad-vim'
Plug 'PyGamer0/vim-apl'
Plug 'kshenoy/vim-signature'

" external programs
" Plug 'ActivityWatch/aw-watcher-vim'
Plug 'alok/notational-fzf-vim'
Plug 'christoomey/vim-tmux-runner'
Plug 'gioele/vim-autoswap'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'junegunn/fzf.vim'
Plug 'mcchrish/nnn.vim'
Plug 'tpope/vim-fugitive'
Plug 'kristijanhusak/vim-carbon-now-sh'

" other
Plug 'Chaitanyabsprip/present.nvim'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'
Plug 'michal-h21/vim-zettel'
Plug 'neovim/nvim-lspconfig'
Plug 'schoettl/listtrans.vim'
Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8' }
Plug 'vimwiki/vimwiki'

call plug#end()

" vim-surround
vnoremap <leader>S( S(JJ

" UltraSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"

" Easymotion
map <leader>fi <Plug>(easymotion-s)
let g:EasyMotion_do_mapping = 0

" Visual-multi
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]             = '<C-j>'
let g:VM_maps["Add Cursor Up"]               = '<C-k>'

" VimWiki
let g:vimwiki_list = [
			\ {'path': '~/Documents/VimWiki/Notes/', 'syntax': 'markdown', 'ext': '.md'},
			\ {'path': '~/Documents/VimWiki/Zettelkasten/', 'syntax': 'markdown', 'ext': '.md'},
			\ {'path': '~/Documents/VimWiki/Dreams/', 'syntax': 'markdown', 'ext': '.md'}]

nmap <leader>wg <Plug>VimwikiGenerateLinks

" Vim-zettel
let g:zettel_options = [{"front_matter" : [["tags", ""]]}, {}, {}]
let g:zettel_format = "%title"
nnoremap <leader>zen :ZettelNew 
nnoremap <leader>zeo :ZettelOpen<CR>

" Goyo
let g:goyo_width = 81
function! s:goyo_enter()
	norm zz
	nnoremap j gjzz
	nnoremap k gkzz
	nnoremap w wzz
	nnoremap b bzz
	setl linebreak
endfunction

function! s:goyo_leave()
	nnoremap j j
	nnoremap k k
	nnoremap w w
	nnoremap b b
endfunction

au! User GoyoEnter nested call <SID>goyo_enter()
au! User GoyoLeave nested call <SID>goyo_leave()

" Emmet
let g:user_emmet_leader_key = '<C-e>'

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:.') !=# '' ? expand('%:.') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

se noshowmode

" NNN
nnoremap <leader>nn :NnnPicker %:p:h<CR>
let g:nnn#layout = 'vnew'
let g:nnn#layout = { 'left': '~20%' }
let g:nnn#set_default_mappings = 1
let g:nnn#command = 'nnn -r -C -e'
let $NNN_PLUG='f:simple-fzf-open;w:setpywal;W:setpywalvid;d:dragdrop;t:preview-tabbed;i:-sxiv;I:d-sxiv'
let $NNN_BMS='D:~/Documents;d:~/Downloads;p:~/Pictures;v:~/Videos;m:~/Music;P:~/.srcpkgs;S:~/.scripts;a:~/.local/bin;s:/mnt/DiskE/Important/STEM;c:~/.config/;M:/media/'
let $NNN_FIFO="/tmp/nnn.fifo"
let $NNN_TRASH=1

" " Titlecase
" let g:titlecase_map_keys = 0
" nnoremap <leader>gt <Plug>Titlecase
" vnoremap <leader>gt <Plug>Titlecase
" nnoremap <leader>gT <Plug>TitlecaseLine

" Startify
let g:startify_bookmarks = [
			\ {'c': '~/.config/nvim/init.vim'},
			\ {'dw': '~/.srcpkgs/dwm/config.def.h'},
			\ {'s':'~/.config/sxhkd/sxhkdrc'},
			\ {'u': '~/.config/qutebrowser/config.py'},
			\ {'a':'~/.config/aliasrc'},
			\ {'zs':'~/.zshrc'},
			\ {'ze':'~/Documents/VimWiki/Zettelkasten/'},
			\ {'ww':'~/Documents/VimWiki/Notes/index.md'},
			\ {'dl':'~/Documents/VimWiki/Dreams/diary/diary.md'},
			\ ]
let g:startify_lists = [
			\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
			\ { 'type': 'files',     'header': ['   MRU']            },
			\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
			\ { 'type': 'sessions',  'header': ['   Sessions']       },
			\ { 'type': 'commands',  'header': ['   Commands']       },
			\ ]
nnoremap <leader>s :Startify<CR>

" RT-Format
let g:rtf_ctrl_enter = 0
let g:rtf_on_insert_leave = 1

" Colorizer
let g:colorizer_auto_color = 1

" FZF
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fg :NV<CR>
nnoremap <leader>b :Buffers<CR>
let g:nv_search_paths = ['~/Documents/VimWiki/']

" listtrans 
nmap tl <Plug>ListtransToggle
vmap tl <Plug>ListtransToggleVisual

" Schlepp
vnoremap <M-k> <Plug>SchleppUp
vnoremap <M-j> <Plug>SchleppDown
vnoremap <M-h> <Plug>SchleppLeft
vnoremap <M-l> <Plug>SchleppRight

" vmath 
vnoremap <expr>  ++  VMATH_YankAndAnalyse()
nnoremap         ++  vip++

" auto-pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", '<':'>'}
let g:AutoPairsShortcutJump = '<C-Space>'
let g:AutoPairsShortcutToggle = '<M-P>'
au FileType markdown let b:AutoPairs = AutoPairsDefine({'**' : '**', '_':'_'})
au FileType apl let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"',}

" Pickachu
inoremap <M-c> <esc>:Pickachu color<CR>a
inoremap <M-f> <esc>:Pickachu file<CR>a
inoremap <M-d> <esc>:Pickachu date<CR>a
nnoremap <M-c> <esc>:Pickachu color<CR>a
nnoremap <M-f> <esc>:Pickachu file<CR>a
nnoremap <M-d> <esc>:Pickachu date<CR>a

" hexokinase
let g:Hexokinase_highlighters = ['foreground']

" Tmux runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
nnoremap <leader>oo :VtrOpenRunner<CR>
nnoremap <leader>or :VtrOpenRunner<CR>:VtrSendFile<CR>
nnoremap <leader>fo :VtrFocusRunner<CR>
nnoremap <leader>k :VtrKillRunner<CR>
nnoremap <leader>r :VtrSendFile<CR>
nnoremap <leader>R :VtrSendLinesToRunner<CR>
vnoremap <leader>r :VtrSendLinesToRunner<CR>
let g:vtr_filetype_runner_overrides = { 'apl': 'apl --OFF -q -f {file}', }

fun! AplSetup()
	nunmap <leader>r
	nunmap <leader>R
	nnoremap <leader>r :VtrSendLinesToRunner<CR>
	nnoremap <leader>R :VtrSendFile<CR>
endf
au FileType apl call AplSetup()

" Grammarous 
let g:grammarous#move_to_first_error = 1
let g:grammarous#show_first_error = 0
nnoremap <leader>Ns <Plug>(grammarous-move-to-next-error)
nnoremap <leader>Ps <Plug>(grammarous-move-to-previous-error)

" which key nvim
lua << EOF
  require("which-key").setup {}
EOF

fun LSP()
" lsp
lua << EOF
  require'lspconfig'.pylsp.setup{}
  require'lspconfig'.clangd.setup{}
  require'lspconfig'.texlab.setup{}
  require'lspconfig'.bashls.setup{}
EOF

" nvim-cmp 
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    sources = cmp.config.sources({
      { name = 'spell' },
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['texlab'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['bashls'].setup {
    capabilities = capabilities
  }

EOF
endf
call LSP()

" vim-carbon-now-sh
let g:carbon_now_sh_browser = 'brave'
vnoremap <leader>c :CarbonNowSh<CR>

set bg=dark
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_number_column = 'bg0'
" let g:gruvbox_transparent_bg = '0'
se termguicolors
colo gruvbox
" " hi Normal ctermbg=none guibg=none
" hi SpellCap guifg=#b8bb26 gui=bold
" hi SpellBad guibg=#fb4934 gui=undercurl
" hi SpellLocal guibg=#8ec07c gui=undercurl
" hi SpellRare guibg=#d3869b gui=undercurl
