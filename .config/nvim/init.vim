" vim:set et sw=4 ts=4 tw=78 fdm=marker:
"  _   _         __     ___           
" | \ | | ___  __\ \   / (_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
" | |\  |  __/ (_) \ V / | | | | | | |
" |_| \_|\___|\___/ \_/  |_|_| |_| |_|
"

let g:python3_host_prog = '/bin/python3'

let g:loaded_sql_completion = 0

colo desert
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

" folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" tabs and indentation
se ts=4 sw=4 et
" se ai ci

" ^A
se nf+=alpha

" timeout
se tm=500

" paths
" se pa+=**
" se pa-=/usr/include

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
" vnoremap  "+y
set clipboard=unnamed,unnamedplus

" tabs
nnoremap <C-Tab> gT
nnoremap <M-C-S-Tab> gt
" nnoremap <s-tab> gT
" nnoremap <tab> gt
nnoremap <M-T> :tabnew<cr>
" au TabLeave * let g:lasttab = tabpagenr()
" nnoremap <M-s> :exe "tabn ".g:lasttab<cr>
" nnoremap <M-i> <tab>

" windows
nnoremap <C-j> j
nnoremap <C-k> k
nnoremap <C-l> l
nnoremap <C-h> h

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
noremap gh 0
noremap gb ^
nnoremap <cr> za
nnoremap <M-CR> Oo

" inoremap <silent> <cr> V:lua vim.lsp.buf.range_formatting()<cr><cr>
" au InsertLeave * :norm V lua vim.lsp.buf.range_formatting()

" escape and save
inoremap  <esc>:w<cr>

" count lines of code
nnoremap g<c-f> :!scc %<cr>
nnoremap g<c-d> :!scc %:p:h<cr>

" nnoremap U <c-r>

" }}} "

" functions {{{ "

" function! MoveEm(position)
"     let saved_cursor = getpos(".")
"     let previous_blank_line = search('^$', 'bn')
"     let target_line = previous_blank_line + a:position - 1
"     execute 'move ' . target_line
"     call setpos('.', saved_cursor)
" endfunction
" for position in range(1, 9)
"     execute 'nnoremap gm' . position . ' :call MoveEm(' . position . ')<cr>'
" endfor

function! s:repeatable(cmd)
  function! s:inner(...) closure abort
    execute a:cmd
  endfunction
  let &opfunc=get(funcref('s:inner'), 'name')
  return 'g@l'
endfunction

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
Plug 'matze/vim-move'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" }}} "

" completions {{{ "
Plug 'DougBeney/pickachu', { 'on': 'Pickachu' }
Plug 'vim-scripts/dbext.vim'
Plug 'SirVer/ultisnips'
Plug 'f3fora/cmp-spell'
Plug 'folke/which-key.nvim'
Plug 'honza/vim-snippets'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-omni'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'jdhao/better-escape.vim'
" Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript'] }
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
" }}} "

" themes {{{ "
Plug 'nvim-lualine/lualine.nvim'
Plug 'ellisonleao/gruvbox.nvim'
" Plug 'romainl/vim-cool'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mhinz/vim-startify'
" Plug 'akinsho/bufferline.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" }}} "

" syntax highlighting {{{ "
Plug 'PyGamer0/vim-apl', {'for': 'apl'}
Plug 'alaviss/nim.nvim'
Plug 'andymass/vim-matchup'
Plug 'baskerville/vim-sxhkdrc', {'for': 'sxhkdrc'}
Plug 'kevinhwang91/nvim-hlslens'
Plug 'kmonad/kmonad-vim', {'for': 'kmonad'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mlochbaum/BQN', {'rtp': 'editors/vim'}
Plug 'tpope/vim-markdown', {'for': ['markdown', 'vimwiki']}
" }}} "

" external programs {{{ "
Plug 'KabbAmine/lazyList.vim', { 'on': 'LazyList' }
Plug 'christoomey/vim-tmux-runner',  { 'on': ['VtrAttachToPane', 'VtrOpenRunner'] }
" Plug 'dstein64/vim-startuptime'
Plug 'gioele/vim-autoswap'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'GFiles', 'Buffers', 'Colors', 'Ag', 'Rg', 'Lines', 'BLines', 'Tags', 'BTags', 'Marks', 'Windows', 'Locate', 'History', 'Snippets', 'Commits', 'BCommits', 'Commands', 'Maps', 'Helptags', 'Filetypes'] }
Plug 'kristijanhusak/vim-carbon-now-sh', { 'on': 'CarbonNowSh' }
Plug 'lervag/vimtex'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'https://git.sr.ht/~detegr/nvim-bqn'
" }}} "

" other {{{ "
" Plug 'Chaitanyabsprip/present.nvim'
" Plug 'chrisbra/Recover.vim'
" Plug 'svermeulen/vim-easyclip'
Plug 'Konfekt/FastFold'
Plug 'ThePrimeagen/harpoon'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'petertriho/nvim-scrollbar'
Plug 'schoettl/listtrans.vim'
Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8', 'for': 'python' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'vimwiki/vimwiki', { 'for': 'markdown' }
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
let g:vimtex_fold_enabled = 1
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
" autocmd User FugitiveIndex,FugitiveObject nnoremap <buffer> cc :vert Git commit<cr>
" autocmd User FugitiveIndex,FugitiveObject nnoremap <buffer> gp :vs<cr>:term<cr>Igp<cr>
" autocmd FileType fugitive nnoremap <buffer> cc :vert Git commit<cr>
" autocmd FileType fugitive nnoremap <buffer> gp :vs<cr>:term<cr>Igp<cr>
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

" " vim-easyclip {{{ "
" nnoremap gm m
" let g:EasyClipAutoFormat = 1
" let g:EasyClipUsePasteToggleDefaults = 0
" let g:EasyClipUsePasteToggleDefaults = 0
" " let g:EasyClipUseSubstituteDefaults = 1
" nnoremap <c-r> <Plug>SubstituteOverMotionMap
" " }}} "

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

" goyo {{{ "
let g:goyo_width = 83
function! s:goyo_enter()
	norm zz
	nnoremap j gjzz
	nnoremap k gkzz
	nnoremap w wzz
	nnoremap b bzz
    nnoremap  zz
    nnoremap  zz
    ScrollbarHide
    Limelight
	" setl linebreak
endfunction

function! s:goyo_leave()
    norm zz
	nnoremap j j
	nnoremap k k
	nnoremap w w
	nnoremap b b
    nnoremap  
    nnoremap  
    ScrollbarShow
    Limelight!
    se termguicolors
    colo gruvbox
endfunction

au! User GoyoEnter nested call <SID>goyo_enter()
au! User GoyoLeave nested call <SID>goyo_leave()
noremap <leader>y :Goyo<cr>
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

" se noshowmode
" }}} "

" vim-startify {{{ "
let g:startify_bookmarks = [
            \ {'c': '~/.config/nvim/init.vim'},
            \ {'d': '~/.srcpkgs/dwm/config.def.h'},
            \ {'s':'~/.config/sxhkd/sxhkdrc'},
            \ {'u': '~/.config/qutebrowser/config.py'},
            \ {'a':'~/.config/aliasrc'},
            \ {'K':'~/.config/KMonad.kbd'},
            \ {'zs':'~/.zshrc'},
            \ {'w':'~/Documents/VimWiki/index.md'},
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
nnoremap <leader>bf :Goyo!<cr>:Buffers<cr>
nnoremap <leader>t :Goyo!<cr>:Tags<cr>
nnoremap <leader>m :Goyo!<cr>:Maps<cr>
nnoremap <leader>wf :Goyo!<cr>:Windows<cr>
" let g:nv_search_paths = ['~/Documents/VimWiki/']
" }}} "

" listtrans {{{ "
nmap tl <Plug>ListtransToggle
vmap tl <Plug>ListtransToggleVisual
" }}} "

" move {{{ "
" inoremap <M-j> :m .+1<cr>==
" inoremap <M-k> :m .-2<cr>==
" vnoremap <M-j> :m '>+1<cr>gv=gv
" vnoremap <M-k> :m '>-2<cr>gv=gv
" }}} "

" " auto-pairs {{{ "
" let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", }
" let g:AutoPairsShortcutJump = '<M-n>'
" let g:AutoPairsShortcutToggle = '<M-p>'
" au FileType markdown,vimwiki let b:AutoPairs = AutoPairsDefine({'*':'*', '**' : '**', '***': '***', '_':'_'})
" au FileType apl let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"',}
" au FileType vim let b:AutoPairs = AutoPairsDefine({'<':'>',})
" au FileType tex let b:AutoPairs = AutoPairsDefine({'$':'$'})
" " }}} "

" pickachu {{{ "
inoremap <M-c> <cmd>Pickachu color<cr>
inoremap <M-f> <cmd>Pickachu file<cr>
inoremap <M-d> <cmd>Pickachu date<cr>
nnoremap <M-c> :Pickachu color<cr>
nnoremap <M-f> :Pickachu file<cr>
nnoremap <M-d> :Pickachu date<cr>
" }}} "

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

" grammarous {{{
let g:grammarous#move_to_first_error = 1
let g:grammarous#show_first_error = 0
nnoremap <leader>Ns <Plug>(grammarous-move-to-next-error)
nnoremap <leader>Ps <Plug>(grammarous-move-to-previous-error)
" }}}

" vim-carbon-now-sh {{{
let g:carbon_now_sh_browser = 'brave'
vnoremap <leader>c :CarbonNowSh<cr>
" }}}

" hexokinase {{{
let g:Hexokinase_highlighters = ['virtual']
" }}}

" Easy Align {{{ "
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}} Easy Align "

" colorscheme {{{ "
set bg=dark
" let g:gruvbox_contrast_dark = 'medium'
" let g:gruvbox_number_column = 'bg0'
" let g:gruvbox_transparent_bg = '0'
let g:gruvbox_italic = 1
se termguicolors
colo gruvbox
" }}} "
" }}} "
" }}} "

" lua {{{ "
lua require('config')

" " lsp {{{ "
" fun! LspKeys()
"     nnoremap <buffer> <silent> <M-h> <cmd>lua vim.lsp.buf.signature_help()<CR>
"     nnoremap <buffer> <silent> <leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
"     nnoremap <buffer> <silent> <leader>ldf <cmd>lua vim.diagnostic.open_float()<CR>
"     nnoremap <buffer> <silent> <leader>ldd <cmd>call v:lua.toggle_diagnostics()<CR>
"     nnoremap <buffer> <silent> <leader>lf <cmd>lua vim.lsp.buf.formatting()<CR>
"     if &ft != 'tex'
"         nnoremap <buffer> <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
"     else
"         nnoremap <buffer> <silent> <leader>lh <cmd>lua vim.lsp.buf.hover()<CR>
"     endif
"     nnoremap <buffer> <silent> <leader>lre <cmd>lua vim.lsp.buf.rename()<CR>
"     nnoremap <buffer> <silent> <leader>lrr <cmd>lua vim.lsp.buf.references()<CR>
"     nnoremap <buffer> <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
"     nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
"     nnoremap <buffer> <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" endf

" " au Filetype tex,python,cpp,bash,html,css,javascript call LspKeys()
" " }}} "

nnoremap <silent><expr> gH
      \ <sid>repeatable('TSTextobjectSwapPrevious @parameter.inner')
nnoremap <silent><expr> gL
      \ <sid>repeatable('TSTextobjectSwapNext @parameter.inner')

" let @h = ';TSTextobjectSwapPrevious @parameter.inner'
" let @l = ';TSTextobjectSwapNext @parameter.inner'
" nnoremap gL @l<cr>
" nnoremap gH @h<cr>

" harpoon {{{ "
nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent> <leader>hm :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent> <leader>hn :lua require("harpoon.ui").nav_next()<CR>
nnoremap <silent> <leader>hp :lua require("harpoon.ui").nav_prev()<CR>
" }}} harpoon "

" }}} "
