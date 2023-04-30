" vim:set et sw=4 ts=4 tw=78 fdm=marker:
"  _   _         __     ___           
" | \ | | ___  __\ \   / (_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
" | |\  |  __/ (_) \ V / | | | | | | |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|
"

let g:loaded_sql_completion = 0

inoremap jk <esc>
" variables {{{ "
" lines numbering
se nu rnu

" line breaks wraping
se wrap lbr

" completions
se cpt+=kspell,t
se cot=menu,menuone,noselect
se icm=nosplit
se wim=longest:full,full
" se wmnu
" se wic

filet plugin indent on
sy enable
" se ofu=syntaxcomplete#Complete
" se cfu=v:lua.vim.lsp.omnifunc

" cursor lines
se cul cuc

" enable mouse
se mouse=a

se title
se ic

" " folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" tabs and indentation
se ts=4 sw=4 et
" se ai ci

" ^A
se nf+=alpha

" timeout
se tm=500

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

" copy to system clipboard
set clipboard=unnamed,unnamedplus

" tabs
nnoremap <C-Tab> gt
nnoremap <M-C-S-Tab> gT
nnoremap <M-T> :tabnew<cr>

" windows
" nnoremap <C-j> j
" nnoremap <C-k> k
" nnoremap <C-l> l
" nnoremap <C-h> h

" spell keys
nnoremap  1z=
nnoremap <leader>ps :normal! mm[s1z=`m<cr>
nnoremap <leader>ns :normal! mm]s1z=`m<cr>

" folds
" nnoremap <space><space> za

" file type detect
nnoremap <leader>ftd :filetype detect<cr>

" update configuration
nnoremap cu :so ~/.config/nvim/init.vim<cr>

" make file executable
nnoremap <leader>x :!chmod +x %<cr>

" create a terminal session and run compiler in it
nnoremap <leader>co :terminal echo % \| entr -s "compiler %"<cr>

" line
noremap gl $
noremap gh ^
noremap gb 0
nnoremap <cr> za
nnoremap <M-CR> Oo

" escape and save
inoremap  <esc>:w<cr>

" }}} "

" functions {{{ "

" }}} "

" auto {{{ "
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"" Suckless programs
au BufWritePost *blocks.def.h !doas rm 'blocks.h' && doas make clean install && { pkill dwmblocks;setsid dwmblocks & }
au BufWritePost *config.h !doas make clean install
"" spell
au FileType text,tex,markdown,vimwiki,gitcommit setl spell
"" other
au BufWritePost sxhkdrc !pkill -USR1 sxhkd
au BufWritePost *.kbd !pkill kmonad; setsid kmonad %:p &
" au BufEnter *.py :RTFormatEnable
au BufRead,BufNewFile *.bqn setf bqn
au BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif
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

ca pla PlugAdd
ca pli PlugInstall

" root write
com! -nargs=0 Sw w !doas tee % > /dev/null

" }}} "

" plugins {{{ "
" definitions {{{ "
call plug#begin('~/.local/share/nvim/plugged')

Plug 'lewis6991/impatient.nvim'

" motions/text objects {{{ "
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-titlecase' 
Plug 'phaazon/hop.nvim'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" }}} "

" completions {{{ "
Plug 'DougBeney/pickachu', { 'on': 'Pickachu' }
Plug 'SirVer/ultisnips'
Plug 'f3fora/cmp-spell'
Plug 'folke/which-key.nvim'
Plug 'honza/vim-snippets'
Plug 'LunarWatcher/auto-pairs'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript'] }
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" }}} "

" themes {{{ "
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'ellisonleao/gruvbox.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mhinz/vim-startify'
Plug 'nvim-lualine/lualine.nvim'
" }}} "

" syntax highlighting {{{ "
Plug 'PyGamer0/vim-apl', {'for': 'apl'}
Plug 'andymass/vim-matchup'
Plug 'baskerville/vim-sxhkdrc', {'for': 'sxhkdrc'}
Plug 'kevinhwang91/nvim-hlslens'
Plug 'kmonad/kmonad-vim'
Plug 'tpope/vim-markdown'
" }}} "

" external programs {{{ "
" Plug 'dstein64/vim-startuptime'
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'wakatime/vim-wakatime'
Plug 'KabbAmine/lazyList.vim', { 'on': 'LazyList' }
Plug 'christoomey/vim-tmux-runner',  { 'on': ['VtrAttachToPane', 'VtrOpenRunner'] }
Plug 'gioele/vim-autoswap'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'GFiles', 'Buffers', 'Colors', 'Ag', 'Rg', 'Lines', 'BLines', 'Tags', 'BTags', 'Marks', 'Windows', 'Locate', 'History', 'Snippets', 'Commits', 'BCommits', 'Commands', 'Maps', 'Helptags', 'Filetypes'] }
Plug 'lervag/vimtex'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
" }}} "

" other {{{ "
Plug 'chrisbra/Recover.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'schoettl/listtrans.vim'
Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8', 'for': 'python' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
" }}} "

call plug#end()
" }}} "

" config {{{ "

" entire {{{ "
let g:textobj_entire_no_default_key_mappings = 1
onoremap aE	<plug>(textobj-entire-a)
onoremap iE	<plug>(textobj-entire-i)
vnoremap aE	<plug>(textobj-entire-a)
vnoremap iE	<plug>(textobj-entire-i)
" }}} entire "

" undotree {{{ "
nnoremap <leader>u :UndotreeToggle<cr>
" }}} undotree "

" md {{{ "
let g:markdown_fenced_languages = ['bash=sh', 'apl', 'python']
" set concealcursor=i
" }}} md "

" VimTex {{{ "
let g:vimtex_view_method = 'zathura_simple'
" let g:vimtex_compiler_method = 'generic'
" let g:vimtex_compiler_generic = {
"             \ 'command' : 'compiler %',
"             \}
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : '',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'hooks' : [],
            \ 'options' : [
                \   '-verbose',
                \   '-file-line-error',
                \   '-synctex=1',
                \   '-interaction=nonstopmode',
                \ ],
                \}
let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-xelatex',
            \}
let g:vimtex_quickfix_open_on_warning = 0
let maplocalleader = " "
" let g:vimtex_fold_enabled = 1
" let g:vimtex_syntax_enabled = 0
" let g:vimtex_syntax_conceal_disable = 1
" }}} "

" LaTeX {{{ "
let g:surround_{char2nr('l')} = "\\begin{\1environment: \1}\r\\end{\1\r}.*\r\1}"
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
" function! OpenZathura()
"     let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
"     call jobstart("zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"tex$","pdf", ""))
" endfunction
" nnoremap <leader>lv :call OpenZathura()<cr>

" nnoremap <silent> <leader>lv :execute "silent !zathura --synctex-forward ".line(".").":".col(".").":%:p %:p:r.pdf"<cr>
" }}} LaTeX "

" vim-fugitive {{{ "
nnoremap <leader>g :G<cr>
" }}} "

" lazyList {{{ "
" ca l LazyList
nnoremap <leader>ii :LazyList<cr>
vnoremap <leader>ii :LazyList<cr>
nnoremap <leader>il :LazyList ' '<Left><Left>
vnoremap <leader>il :LazyList ' '<Left><Left>
nnoremap <leader>i- :LazyList '- '<cr>
vnoremap <leader>i- :LazyList '- '<cr>
nnoremap <leader>i* :LazyList '* '<cr>
vnoremap <leader>i* :LazyList '* '<cr>
nnoremap <leader>it :LazyList '- [ ] '<cr>
vnoremap <leader>it :LazyList '- [ ] '<cr>
" }}} "

" listtrans {{{ "
nmap tl <Plug>ListtransToggle
vmap tl <Plug>ListtransToggleVisual
" }}} "

" ultrasnips {{{ "
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"
" }}} "

" hop {{{ "
noremap <leader>j <cmd>HopChar1<cr>
" nnoremap <leader>fi (easymotion-overwin-f)
" noremap <leader>fw zR<Plug>(easymotion-bd-w)
" }}} "

" visual-multi {{{ "
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]             = '<C-S-K>'
let g:VM_maps["Add Cursor Up"]               = '<S-NL>'
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'
" }}} "

" vimwiki {{{ "
let g:vimwiki_list = [
			\ {'path': '~/Documents/VimWiki/', 'syntax': 'markdown', 'ext': '.md'},
            \ ]
nmap <leader>wg <Plug>VimwikiGenerateLinks
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

" }}} "

" vim-startify {{{ "
let g:startify_bookmarks = [
            \ {'c': '~/.config/nvim/init.vim'},
            \ {'d': '~/.srcpkgs/dwm/config.def.h'},
            \ {'s':'~/.config/sxhkd/sxhkdrc'},
            \ {'a':'~/.config/aliasrc'},
            \ {'K':'~/.config/KMonad.kbd'},
            \ {'F':'~/.config/fish/config.fish'},
            \ ]
let g:startify_lists = [
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'files',     'header': ['   MRU']            },
            \ ]
nnoremap <leader>s :Startify<cr>
" }}} "

" rt-format {{{ "
let g:rtf_ctrl_enter = 0
let g:rtf_on_insert_leave = 1
" }}} "

" fzf {{{ "
nnoremap <leader>ff :FZF<cr>
" nnoremap <leader>fg :NV<cr>
nnoremap <leader>bf :Buffers<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>m :Maps<cr>
nnoremap <leader>wf :Windows<cr>
" }}} "

" pickachu {{{ "
inoremap <M-c> <cmd>Pickachu color<cr>
inoremap <M-f> <cmd>Pickachu file<cr>
inoremap <M-d> <cmd>Pickachu date<cr>
nnoremap <M-c> :Pickachu color<cr>
nnoremap <M-f> :Pickachu file<cr>
nnoremap <M-d> :Pickachu date<cr>
" }}} "

" Auto Pairs {{{ "
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", }
let g:AutoPairsCompatibleMaps = 1
let g:AutoPairsMapBS = 1

au FileType markdown let b:AutoPairs = AutoPairsDefine({'*' : '*'})
au FileType apl let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"',}
au FileType vim let b:AutoPairs = AutoPairsDefine({'<':'>',})
au FileType tex let b:AutoPairs = AutoPairsDefine({'$':'$'})

" }}} Auto Pairs "

" tmux runner {{{ "
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
let g:VtrAutomaticReattachByName = 1
nnoremap <leader>a :VtrAttachToPane<cr>
nnoremap <leader>oo :VtrOpenRunner<cr>
nnoremap <leader>or :VtrOpenRunner<cr>:VtrSendFile<cr>
nnoremap <leader>fo :VtrFocusRunner<cr>
nnoremap <leader>k :VtrKillRunner<cr>
nnoremap <leader>r :VtrSendFile<cr>
nnoremap <leader>R :VtrSendLinesToRunner<cr>
vnoremap <leader>r :VtrSendLinesToRunner<cr>
let g:vtr_filetype_runner_overrides = {
            \ 'apl': 'apl --OFF -q -f {file}',
            \ 'python': 'python3 {file}',
            \ 'sql': 'mysql {file}',
            \ 'mysql': 'mysql {file}',
            \ }

fun! AplSetup()
	nunmap <leader>r
	nunmap <leader>R
	nnoremap <leader>r :VtrSendLinesToRunner<cr>
	nnoremap <leader>R :VtrSendFile<cr>
    let g:VtrPercentage = 80
endf
au FileType apl call AplSetup()
" }}} "

" hexokinase {{{
let g:Hexokinase_highlighters = ['virtual']
" }}}

" Easy Align {{{ "
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}} Easy Align "

" colorscheme {{{ "
" set bg=dark
" let g:gruvbox_contrast_dark = 'medium'
" let g:gruvbox_number_column = 'bg0'
" let g:gruvbox_transparent_bg = '0'
" let g:gruvbox_italic = 1
" se termguicolors
" colo gruvbox
" set termguicolors
" colo wal
" }}} "
" }}} "
" }}} "

lua require('config')
