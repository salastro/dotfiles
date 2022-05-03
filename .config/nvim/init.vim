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

" tabs
se ts=4 sw=4 et

" folds
se fdm=marker

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
nnoremap <C-H> gT
nnoremap <C-L> gt
" nnoremap <s-tab> gT
" nnoremap <tab> gt
nnoremap <M-T> :tabnew<cr>
" au TabLeave * let g:lasttab = tabpagenr()
" nnoremap <M-s> :exe "tabn ".g:lasttab<cr>
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

" }}} "

" functions {{{ "

" function! MoveEm(position)
"   let saved_cursor = getpos(".")
"   let previous_blank_line = search('^$', 'bn')
"   let target_line = previous_blank_line + a:position - 1
"   execute 'move ' . target_line
"   call setpos('.', saved_cursor)
" endfunction
" for position in range(1, 9)
"   execute 'nnoremap gm' . position . ' :call MoveEm(' . position . ')<cr>'
" endfor

" }}} "

" auto {{{ "
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"" Suckless programs
au BufWritePost *blocks.def.h !doas rm 'blocks.h' && doas make clean install && { pkill dwmblocks;setsid dwmblocks & }
au BufWritePost *config.def.h !doas rm 'config.h' && doas make clean install
"" spell
au FileType text,tex,markdown,vimwiki,gitcommit setl spell
"" other
au BufWritePost sxhkdrc !pkill -USR1 sxhkd
au BufWritePost *.kbd !pkill kmonad; setsid kmonad %:p &
au BufEnter *.py :RTFormatEnable
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
Plug 'easymotion/vim-easymotion'
" Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'matze/vim-move'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
" }}} "

" completions {{{ "
Plug 'DougBeney/pickachu', { 'on': 'Pickachu' }
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
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript'] }
" Plug 'nixon/vim-vmath'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
" }}} "

" themes {{{ "
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" }}} "

" syntax highlighting {{{ "
" Plug 'cespare/vim-toml'
" Plug 'jbgutierrez/vim-better-comments'
" Plug 'kshenoy/vim-signature'
Plug 'PyGamer0/vim-apl'
Plug 'Yggdroot/indentLine'
Plug 'andymass/vim-matchup'
Plug 'baskerville/vim-sxhkdrc'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'kmonad/kmonad-vim'
Plug 'tpope/vim-markdown'
" }}} "

" external programs {{{ "
" Plug 'ActivityWatch/aw-watcher-vim'
" Plug 'alok/notational-fzf-vim'
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'karoliskoncevicius/vim-sendtowindow'
Plug 'KabbAmine/lazyList.vim', { 'on': 'LazyList' }
Plug 'christoomey/vim-tmux-runner',  { 'on': 'VtrAttachToPane' }
Plug 'gioele/vim-autoswap'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'GFiles', 'Buffers', 'Colors', 'Ag', 'Rg', 'Lines', 'BLines', 'Tags', 'BTags', 'Marks', 'Windows', 'Locate', 'History', 'Snippets', 'Commits', 'BCommits', 'Commands', 'Maps', 'Helptags', 'Filetypes'] }
Plug 'kristijanhusak/vim-carbon-now-sh', { 'on': 'CarbonNowSh' }
" Plug 'lervag/vimtex', { 'for': ['tex', 'bib'] }
Plug 'lervag/vimtex'
Plug 'mcchrish/nnn.vim', { 'on': ['NnnPicker', 'NnnExplorer'] }
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'dstein64/vim-startuptime'
" }}} "

" other {{{ "
" Plug 'chrisbra/Recover.vim'
" Plug 'Chaitanyabsprip/present.nvim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
Plug 'petertriho/nvim-scrollbar'
Plug 'schoettl/listtrans.vim'
Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8', 'for': 'python' }
Plug 'svermeulen/vim-easyclip'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'vimwiki/vimwiki', { 'for': 'markdown' }
" }}} "

call plug#end()
" }}} "

" config {{{ "

nnoremap <leader>u :UndotreeToggle<cr>

let g:markdown_fenced_languages = ['bash=sh', 'apl']
" set concealcursor=i

" VimTex {{{ "
let g:vimtex_view_method = 'zathura'
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
let g:surround_108 = "\\begin{\1environment: \1}\r\\end{\1\1}"
" }}} "

" indentLine {{{ "
au FileType tex,markdown,vimwiki IndentLinesDisable
" }}} "

" vim-fugitive {{{ "
nnoremap <leader>g :G<cr>
" autocmd User FugitiveIndex,FugitiveObject nnoremap <buffer> cc :vert Git commit<cr>
" autocmd User FugitiveIndex,FugitiveObject nnoremap <buffer> gp :vs<cr>:term<cr>Igp<cr>
" autocmd FileType fugitive nnoremap <buffer> cc :vert Git commit<cr>
" autocmd FileType fugitive nnoremap <buffer> gp :vs<cr>:term<cr>Igp<cr>
" }}} "

" " lazyList {{{ "
" nnoremap <leader>li :LazyList 
" vnoremap <leader>li :LazyList 
" nnoremap <leader>ll :LazyList<cr>
" vnoremap <leader>ll :LazyList<cr>
" nnoremap <leader>l- :LazyList '- '<cr>
" vnoremap <leader>l- :LazyList '- '<cr>
" nnoremap <leader>l* :LazyList '* '<cr>
" vnoremap <leader>l* :LazyList '* '<cr>
" nnoremap <leader>lt :LazyList '- [ ] '<cr>
" vnoremap <leader>lt :LazyList '- [ ] '<cr>
" " }}} "

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

" nnn {{{ "
nnoremap <leader>nn :NnnPicker %:p:h<cr>
nnoremap <leader>ne :NnnExplorer %:p:h<cr>
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
        \ {'d': '~/.srcpkgs/dwm/config.def.h'},
        \ {'s':'~/.config/sxhkd/sxhkdrc'},
        \ {'u': '~/.config/qutebrowser/config.py'},
        \ {'a':'~/.config/aliasrc'},
        \ {'K':'~/.config/KMonad.kbd'},
        \ {'zs':'~/.zshrc'},
        \ {'w':'~/Documents/VimWiki/Notes/index.md'},
        \ ]
let g:startify_lists = [
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'commands',  'header': ['   Commands']       },
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
nnoremap <leader>b :Goyo!<cr>:Buffers<cr>
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

" vmath {{{ " 
vnoremap <expr>  ++  VMATH_YankAndAnalyse()
nnoremap         ++  vip++
" }}} "

" auto-pairs {{{ "
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", }
let g:AutoPairsShortcutJump = '<M-n>'
let g:AutoPairsShortcutToggle = '<M-p>'
au FileType markdown,vimwiki let b:AutoPairs = AutoPairsDefine({'*':'*', '**' : '**', '***': '***', '_':'_'})
au FileType apl let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"',}
au FileType vim let b:AutoPairs = AutoPairsDefine({'<':'>',})
au FileType tex let b:AutoPairs = AutoPairsDefine({'$':'$'})
" }}} "

" pickachu {{{ "
inoremap <M-c> :Pickachu color<cr>
inoremap <M-f> :Pickachu file<cr>
inoremap <M-d> :Pickachu date<cr>
nnoremap <M-c> :Pickachu color<cr>
nnoremap <M-f> :Pickachu file<cr>
nnoremap <M-d> :Pickachu date<cr>
" }}} "

" tmux runner {{{ "
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
nnoremap <leader>a :VtrAttachToPane<cr>
nnoremap <leader>oo :VtrOpenRunner<cr>
nnoremap <leader>or :VtrOpenRunner<cr>:VtrSendFile<cr>
nnoremap <leader>fo :VtrFocusRunner<cr>
nnoremap <leader>k :VtrKillRunner<cr>
nnoremap <leader>r :VtrSendFile<cr>
nnoremap <leader>R :VtrSendLinesToRunner<cr>
vnoremap <leader>r :VtrSendLinesToRunner<cr>
let g:vtr_filetype_runner_overrides = { 'apl': 'apl --OFF -q -f {file}', }

fun! AplSetup()
	nunmap <leader>r
	nunmap <leader>R
	nnoremap <leader>r :VtrSendLinesToRunner<cr>
	nnoremap <leader>R :VtrSendFile<cr>
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
let g:Hexokinase_highlighters = ['foreground']
" }}}

" colorscheme {{{ "
set bg=dark
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_number_column = 'bg0'
" let g:gruvbox_transparent_bg = '0'
let g:gruvbox_italic = 1
se termguicolors
colo gruvbox
" }}} "
" }}} "
" }}} "

" lua {{{ "
lua require('config')

" lsp {{{ "
nnoremap <leader>h :lua vim.lsp.buf.hover()<cr>
nnoremap <leader>d :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>e :lua vim.lsp.buf.references()<cr>
" }}} "

" }}} "
