"  _   _         __     ___           
" | \ | | ___  __\ \   / (_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
" | |\  |  __/ (_) \ V / | | | | | | |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|
"

" variables {{{ "
" lines numbering
se nu rnu

" line breaks wraping
se wrap linebreak

" completions
se cpt+=kspell,t
se cot=menu,menuone,noselect
se icm=nosplit
se wim=longest:full,full
se wmnu
se ofu=syntaxcomplete#Complete

" cursor lines
se cursorline cursorcolumn

" enable mouse
se mouse=a

se title 
" se scs
se ic

" tabs
se tabstop=4 shiftwidth=4 expandtab

" folds
se fdm=marker

" 
se nf+=alpha
" }}} "

" keybinds {{{ "
" leader
let mapleader = " "

" search
vnoremap  "+y:%s/\V"/
vnoremap  "+y/\V"
nnoremap n nzvzz
nnoremap N Nzvzz

" cmd mode
noremap ; :
noremap : ;

" copy to clipboard
" vnoremap  "+y
set clipboard=unnamed,unnamedplus

" tabs
nnoremap  gT
nnoremap  gt
" nnoremap <s-tab> gT
" nnoremap <tab> gt
nnoremap <M-T> :tabnew<CR>
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <M-s> :exe "tabn ".g:lasttab<cr>
" nnoremap <M-i> <tab>

" windows
nnoremap <M-J> j
nnoremap <M-K> k
nnoremap <M-L> l
nnoremap <M-H> h

" spell keys
nnoremap  1z=
nnoremap <leader>ps :normal! mm[s1z=`m<cr>
nnoremap <leader>ns :normal! mm]s1z=`m<cr>

" ctags
nnoremap <leader>mc :!ctags -R .<cr>

" folds
nnoremap <space><space> za

" file type detect
nnoremap <leader>ftd :filetype detect<CR>

" update configuration
nnoremap cu :so ~/.config/nvim/init.vim<CR>
" }}} "

" functions {{{ "
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
" }}} "

" auto {{{ "
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
" }}} "

" comands {{{ "
"" compiler
com! Compile !compiler %

"" sent prsentations
com! Sent !sent-pywal-theme % &

" plugins
com! PlugAdd normal oPlug '+'dF.F/F/vT'd

" help
ca h  tab help
ca hv vert help

" root write
command! -nargs=0 Sw w !doas tee % > /dev/null
" }}} "

" plugins {{{ "
" definitions {{{ "
call plug#begin('~/.local/share/nvim/plugged')

" motions {{{ "
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
" }}} "

" completions {{{ "
Plug 'DougBeney/pickachu'
Plug 'SirVer/ultisnips'
Plug 'f3fora/cmp-spell'
Plug 'hrsh7th/cmp-cmdline'
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
" }}} "

" themes {{{ "
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" }}} "

" syntax highlighting {{{ "
Plug 'PyGamer0/vim-apl'
Plug 'andymass/vim-matchup'
Plug 'Yggdroot/indentLine'
Plug 'baskerville/vim-sxhkdrc'
Plug 'cespare/vim-toml'
" Plug 'jbgutierrez/vim-better-comments'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'kmonad/kmonad-vim'
Plug 'kshenoy/vim-signature'
" }}} "

" external programs {{{ "
" Plug 'ActivityWatch/aw-watcher-vim'
" Plug 'alok/notational-fzf-vim'
Plug 'christoomey/vim-tmux-runner'
Plug 'KabbAmine/lazyList.vim'
Plug 'gioele/vim-autoswap'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'junegunn/fzf.vim'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'mcchrish/nnn.vim'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'github/copilot.vim'
" }}} "

" other {{{ "
Plug 'Chaitanyabsprip/present.nvim'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
Plug 'tpope/vim-speeddating'
Plug 'schoettl/listtrans.vim'
Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8' }
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-easyclip'
" }}} "

call plug#end()
" }}} "

" config {{{ "

nnoremap <leader>li :LazyList 
vnoremap <leader>li :LazyList 
nnoremap <leader>ll :LazyList<CR>
vnoremap <leader>ll :LazyList<CR>
nnoremap <leader>l- :LazyList '- '<CR>
vnoremap <leader>l- :LazyList '- '<CR>
nnoremap <leader>l* :LazyList '* '<CR>
vnoremap <leader>l* :LazyList '* '<CR>
nnoremap <leader>lt :LazyList '- [ ] '<CR>
vnoremap <leader>lt :LazyList '- [ ] '<CR>

" vim-easyclip {{{ "
let g:EasyClipAutoFormat = 1
let g:EasyClipUsePasteToggleDefaults = 0
" }}} "

" ultrasnips {{{ "
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"
" }}} "

" easymotion {{{ "
let g:EasyMotion_do_mapping = 0
map <leader>fi zR<Plug>(easymotion-s)
nmap <leader>fi zR<Plug>(easymotion-overwin-f)
map <leader>fw zR<Plug>(easymotion-bd-w)
" }}} "

" visual-multi {{{ "
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]             = '<C-j>'
let g:VM_maps["Add Cursor Up"]               = '<C-k>'
" }}} "

" vimwiki {{{ "
let g:vimwiki_list = [
			\ {'path': '~/Documents/VimWiki/Notes/', 'syntax': 'markdown', 'ext': '.md'},
			\ {'path': '~/Documents/VimWiki/Zettelkasten/', 'syntax': 'markdown', 'ext': '.md'},
			\ {'path': '~/Documents/VimWiki/Dreams/', 'syntax': 'markdown', 'ext': '.md'}]
nmap <leader>wg <Plug>VimwikiGenerateLinks

" vim-zettel
let g:zettel_options = [{"front_matter" : [["tags", ""]]}, {}, {}]
let g:zettel_format = "%title"
nnoremap <leader>zen :ZettelNew 
nnoremap <leader>zeo :ZettelOpen<CR>
" }}} "

" goyo {{{ "
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
" }}} "

" emmet-vim {{{ "
let g:user_emmet_leader_key = '<C-e>'
" }}} "

" lightline {{{ "
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
" }}} "

" nnn {{{ "
nnoremap <leader>nn :NnnPicker %:p:h<CR>
nnoremap <leader>ne :NnnExplorer %:p:h<CR>
let g:nnn#layout = 'vnew'
let g:nnn#layout = { 'left': '~25%' }
let g:nnn#set_default_mappings = 1
let g:nnn#command = 'nnn -o -r -C -e'
let $NNN_COLORS="263"
let $NNN_PLUG='d:dragdrop;P:preview-tui;D:diffs;p:fzplug;w:wallpaper;c:fzcd;i:imgview;F:fixname;x:togglex;f:fzopen'
let $NNN_BMS='D:~/Documents;d:~/Downloads;p:~/Pictures;v:~/Videos;m:~/Music;P:~/.srcpkgs;S:~/.scripts;a:~/.local/bin;s:/mnt/DiskE/Important/STEM;c:~/.config/;M:/media/;w:~/Documents/VimWiki/'
let $NNN_FIFO="/tmp/nnn.fifo"
let $NNN_TRASH=1
let g:nnn#replace_netrw = 1
" autocmd! FileType nnn tnoremap <buffer> l <cr>
" }}} "

" vim-startify {{{ "
let g:startify_bookmarks = [
			\ {'c': '~/.config/nvim/init.vim'},
			\ {'dw': '~/.srcpkgs/dwm/config.def.h'},
			\ {'s':'~/.config/sxhkd/sxhkdrc'},
			\ {'u': '~/.config/qutebrowser/config.py'},
			\ {'a':'~/.config/aliasrc'},
            \ {'K':'~/.config/KMonad.kbd'},
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
" }}} "

" rt-format {{{ "
let g:rtf_ctrl_enter = 0
let g:rtf_on_insert_leave = 1
" }}} "

" fzf {{{ "
nnoremap <leader>ff :FZF<CR>
" nnoremap <leader>fg :NV<CR>
nnoremap <leader>b :Buffers<CR>
" let g:nv_search_paths = ['~/Documents/VimWiki/']
" }}} "

" listtrans {{{ "
nmap tl <Plug>ListtransToggle
vmap tl <Plug>ListtransToggleVisual
" }}} "

" move {{{ "
" inoremap <M-j> :m .+1<CR>==
" inoremap <M-k> :m .-2<CR>==
" vnoremap <M-j> :m '>+1<CR>gv=gv
" vnoremap <M-k> :m '>-2<CR>gv=gv
" }}} "

" vmath {{{ " 
vnoremap <expr>  ++  VMATH_YankAndAnalyse()
nnoremap         ++  vip++
" }}} "

" auto-pairs {{{ "
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", }
let g:AutoPairsShortcutJump = '<M-n>'
let g:AutoPairsShortcutToggle = '<M-p>'
au FileType markdown let b:AutoPairs = AutoPairsDefine({'**' : '**', '_':'_'})
au FileType apl let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"',}
au FileType vim let b:AutoPairs = AutoPairsDefine({'<':'>',})
" }}} "

" pickachu {{{ "
inoremap <M-c> <esc>:Pickachu color<CR>a
inoremap <M-f> <esc>:Pickachu file<CR>a
inoremap <M-d> <esc>:Pickachu date<CR>a
nnoremap <M-c> <esc>:Pickachu color<CR>a
nnoremap <M-f> <esc>:Pickachu file<CR>a
nnoremap <M-d> <esc>:Pickachu date<CR>a
" }}} "

" tmux runner {{{ "
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
nnoremap <leader>a :VtrAttachToPane<CR>
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
" }}} "

" grammarous {{{
let g:grammarous#move_to_first_error = 1
let g:grammarous#show_first_error = 0
nnoremap <leader>Ns <Plug>(grammarous-move-to-next-error)
nnoremap <leader>Ps <Plug>(grammarous-move-to-previous-error)
" }}}

" which key nvim {{{
lua << EOF
  require("which-key").setup {}
EOF
" }}}

" lsp {{{ "
lua << EOF
  require'lspconfig'.pylsp.setup{}
  require'lspconfig'.clangd.setup{}
  require'lspconfig'.texlab.setup{}
  require'lspconfig'.bashls.setup{}
EOF

" nvim-cmp {{{ "
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    },
    sources = cmp.config.sources({
      { name = 'spell' },
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

    cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
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
" }}} "
" }}} "

" vim-carbon-now-sh {{{
let g:carbon_now_sh_browser = 'brave'
vnoremap <leader>c :CarbonNowSh<CR>
" }}}

" hexokinase {{{
let g:Hexokinase_highlighters = ['foreground']
" }}}

" colorscheme {{{ "
set bg=dark
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_number_column = 'bg0'
" let g:gruvbox_transparent_bg = '0'
se termguicolors
colo gruvbox
" }}} "
" }}} "
" }}} "

