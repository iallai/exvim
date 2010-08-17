" ======================================================================================
" File         : .vimrc
" Author       : Wu Jie 
" Last Change  : 12/02/2009 | 12:02:28 PM | Wednesday,December
" Description  : 
" ======================================================================================

"/////////////////////////////////////////////////////////////////////////////
" exVim global settings
" NOTE: you should change to your own settings.
"/////////////////////////////////////////////////////////////////////////////

" set EX_DEV variable for linux
if has ("unix")
    let $EX_DEV='~/exDev'
    let g:ex_toolkit_path = $HOME.'/.toolkit'

    " NOTE: mac is unix like system, but to use gawk,id-utils correctly, we need to manually set the export path.  
    if has ("mac")
        let $PATH='/usr/local/bin/:'.$PATH
    endif
else " else if win32 or other system, just set the toolkit path.
    let g:ex_toolkit_path = $EX_DEV.'/exVim/toolkit'
endif

" put your own user name here
let g:ex_usr_name = "Wu Jie"

"/////////////////////////////////////////////////////////////////////////////
" General
"/////////////////////////////////////////////////////////////////////////////

set nocompatible " Use Vim settings, rather then Vi settings (much better!). This must be first, because it changes other options as a side effect.
set langmenu=none " always use English menu

" always use english for anaything in vim-editor. 
if has ("win32")
    silent exec "language english" 
else
    silent exec "language en_US" 
endif

au FileType c,cpp,cs,swig set nomodeline " this will avoid bug in my project with namespace ex, the vim will tree ex:: as modeline.

" source $VIMRUNTIME/vimrc_example.vim
behave xterm  " set mouse behavior as xterm

"set path=.,/usr/include/*,, " where gf, ^Wf, :find will search 
set backup " make backup file and leave it around 
"UNUSED: set backupdir=%tmp%
"UNUSED: set directory=.,%tmp%

" setup back and swap directory
let data_dir = $HOME.'/.data/'
let backup_dir = data_dir . 'backup' 
let swap_dir = data_dir . 'swap' 
if finddir(data_dir) == ''
    silent call mkdir(data_dir)
endif
if finddir(backup_dir) == ''
    silent call mkdir(backup_dir)
endif
if finddir(swap_dir) == ''
    silent call mkdir(swap_dir)
endif
set backupdir=$HOME/.data/backup " where to put backup file 
set directory=$HOME/.data/swap " where to put swap file 
unlet data_dir
unlet backup_dir
unlet swap_dir

" programming related 
set tags+=./tags,./../tags,./**/tags,tags " which tags files CTRL-] will find 
set makeef=error.err " the errorfile for :make and :grep 

" NOTE: viminfo
" for MS-DOS, Windows and OS/2: '20,<50,s10,h,rA:,rB:,
" for Amiga: '20,<50,s10,h,rdf0:,rdf1:,rdf2:
" for others: '20,<50,s10,h
set viminfo+=! " make sure it can save viminfo 
filetype on " enable file type detection 
filetype plugin on " enable loading the plugin for appropriate file type 

" Redefine the shell redirection operator to receive both the stderr messages
" and stdout messages
set shellredir=>%s\ 2>&1

set history=50 " keep 50 lines of command line history
set updatetime=1000 " default = 4000
set autoread " auto read same-file change ( better for vc/vim change )

" XXX
"set isk+=$,%,#,- " none of these should be word dividers 

" FIXME: no fix yet in vim72
" there have a bug with visual copy, shows the there is nothing in register *
" set clipboard=unnamed " use clipboard register '*'(unnamed) for all y, d, c, p ops, use autoselect to avoid selection p bugs.

" enlarge maxmempattern from 1000 to ... (2000000 will give it without limit)
set maxmempattern=1000

" DISABLE: done in exQuickFix { 
" set quick fix error format
" default errorformat = %f(%l) : %t%*\D%n: %m,%*[^"]"%f"%*\D%l: %m,%f(%l) : %m,%*[^ ] %f %l: %m,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,%f|%l| %m
"set errorformat+=%D%\\d%\\+\>------\ %.%#Project:\ %f%\\,%.%# " msvc 2005 error-entering
"set errorformat+=%D%\\d%\\+\>------\ %.%#Project:\ %f%\\,%.%# " msvc 2005 error-entering
"set errorformat+=%X%\\d%\\+\>%.%#%\\d%\\+\ error(s)%.%#%\\d%\\+\ warning(s) " msvc 2005 error-leaving
"set errorformat+=%\\d%\\+\>%f(%l)\ :\ %t%*\\D%n:\ %m " msvc 2005 error-format
"set errorformat+=%f(%l\\,%c):\ %m " fxc shader error-format
" } DISABLE end 

"/////////////////////////////////////////////////////////////////////////////
" xterm settings
"/////////////////////////////////////////////////////////////////////////////

if &term =~ "xterm"
    set mouse=a
endif

"/////////////////////////////////////////////////////////////////////////////
" Variable settings ( set all )
"/////////////////////////////////////////////////////////////////////////////

" ------------------------------------------------------------------ 
" Desc: Visual
" ------------------------------------------------------------------ 

set showmatch " show matching paren 
set matchtime=0 " 0 second to show the matching paren ( much faster )
set nu " Show LineNumber
set scrolloff=0 " minimal number of screen lines to keep above and below the cursor 
set nowrap " I don't like wrap, cause in split window mode, it feel strange

" set default guifont
if has("gui_running")
    " check and determine the gui font after GUIEnter. 
    " NOTE: getfontname function only works after GUIEnter.  
    au GUIEnter * call s:SetGuiFont() 
endif
" set guifont
function s:SetGuiFont()
    if has("gui_gtk2")
        set guifont=Luxi\ Mono\ 10
    elseif has("x11")
        " Also for GTK 1
        set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("mac")
        if getfontname( "Bitstream_Vera_Sans_Mono" ) != ""
            set guifont=Bitstream\ Vera\ Sans\ Mono:h13
        elseif getfontname( "DejaVu\ Sans\ Mono" ) != ""
            set guifont=DejaVu\ Sans\ Mono:h13
        endif
    elseif has("gui_win32")
        let font_name = ""
        if getfontname( "Bitstream_Vera_Sans_Mono" ) != ""
            set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
            let font_name = "Bitstream_Vera_Sans_Mono" 
        elseif getfontname( "Consolas" ) != ""
            set guifont=Consolas:h11:cANSI " this is the default visual studio font
            let font_name = "Consolas" 
        else
            set guifont=Lucida_Console:h10:cANSI
            let font_name = "Lucida_Console" 
        endif
        silent exec "nnoremap <unique> <M-F1> :set guifont=".font_name.":h11:cANSI<CR>"
    endif
endfunction

" color scheme define
if has("gui_running")
    " silent exec "colorscheme ex"
    silent exec "colorscheme ex_lightgray"
else " if we are in terminal mode
    " NOTE: you cannot use if has('mac') to detect platform in terminal mode.
    silent exec "colorscheme default"
    " silent exec "colorscheme darkblue"
endif

" ------------------------------------------------------------------ 
" Desc: Vim UI
" ------------------------------------------------------------------ 

set wildmenu " turn on wild menu, try typing :h and press <Tab> 
set showcmd	" display incomplete commands
set cmdheight=1 " 1 screen lines to use for the command-line 
set ruler " show the cursor position all the time
set hid " allow to change buffer without saving 
set shortmess=atI " shortens messages to avoid 'press a key' prompt 
set lazyredraw " do not redraw while executing macros (much faster) 
set display+=lastline " for easy browse last line with wrap text
set laststatus=2 " always have status-line
" TODO: set statusline=    " statusline with different color 'User1-9'

" Set window's width to 130 columns and height to 40 rows
" (if it's GUI)
if has("gui_running")
    set lines=40 columns=130
endif

set showfulltag " show tag with function protype.
set guioptions+=b " Present the bottom scrollbar when the longest visible line exceen the window

" disable menu & toolbar
set guioptions-=m
set guioptions-=T

"set encoding=japan
"set termencoding=cp932

"set encoding=cp932
"set termencoding=cp932

"set grepprg=grep\ -n

" set default encoding to utf-8
set encoding=utf-8
set termencoding=utf-8

" ------------------------------------------------------------------ 
" Desc: Text edit
" ------------------------------------------------------------------ 

set ai " autoindent 
set si " smartindent 
set backspace=indent,eol,start " allow backspacing over everything in insert mode
" indent options
"  see help cinoptions-values for more details
set	cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b0,g0,hs,ps,ts,is,+s,c3,C0,0,(0,us,U0,w0,W0,m0,j0,)20,*30
" default '0{,0},0),:,0#,!^F,o,O,e' disable 0# for not ident preprocess
" set cinkeys=0{,0},0),:,!^F,o,O,e

" Official diff settings
set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary -w '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    silent execute '!' .  'diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction

set cindent shiftwidth=4 " Set cindent on to autoinent when editing C/C++ file, with 4 shift width
set tabstop=4 " Set tabstop to 4 characters
set expandtab " Set expandtab on, the tab will be change to space automaticaly

" Set Number format to null(default is octal) , when press CTRL-A on number
" like 007, it would not become 010
set nf=
" In Visual Block Mode, cursor can be positioned where there is no actual character
set ve=block

" ------------------------------------------------------------------ 
" Desc: Fold text
" ------------------------------------------------------------------ 

set foldmethod=marker foldmarker={,} foldlevel=9999
set diffopt=filler,context:9999

" ------------------------------------------------------------------ 
" Desc: Search
" ------------------------------------------------------------------ 

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
set incsearch " do incremental searching
set ignorecase " Set search/replace pattern to ignore case 
set smartcase " Set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.

" set this to use id-utils for global search
set grepprg=lid\ -Rgrep\ -s
set grepformat=%f:%l:%m

" ------------------------------------------------------------------ 
" Desc: Syntax
" ------------------------------------------------------------------ 

let c_gnu = 1
let c_no_curly_error = 1
"let c_no_bracket_error = 1

"/////////////////////////////////////////////////////////////////////////////
" Key Mappings
"/////////////////////////////////////////////////////////////////////////////

" NOTE: F10 looks like have some feature, when map with F10, the map will take no effects

" Don't use Ex mode, use Q for formatting
map Q gq  

" DISABLE: it is no-use now, also we use \fc for exProject { 
" Set new Rgrep as the grep to search patterns on the C/C++ files as default
"command -nargs=+ Rgrep :grep -r --include="*.cpp" --include="*.c" --include="*.hpp" --include="*.h" <q-args> *
"map <Leader>fc :call <SID>Grep_Cfiles()<CR>
"function s:Grep_Cfiles()
"    let l_str=input("Input the keyword to be searched: ")
"    exec ":grep -r --include=\"*.cpp\" --include=\"*.c\" --include=\"*.hpp\" --include=\"*.h\" " . l_str . " *"
"endfunction
" } DISABLE end 

" define the copy/paste judged by clipboard
if &clipboard ==# "unnamed"
    " fix the visual paste bug in vim
    " vnoremap <silent>p :call g:()<CR>
else
    " general copy/paste.
    " NOTE: y,p,P could be mapped by other key-mapping
    map <unique> <leader>y "*y
    map <unique> <leader>p "*p
    map <unique> <leader>P "*P
endif

" F8:  Set Search pattern highlight on/off
nnoremap <unique> <F8> :let @/=""<CR>

" fast encoding change. 
if has("gui_running") "  the <alt> key is only available in gui mode.
    " DISABLE: done in s:SetGuiFont() function { 
    " M-F1:  Switch to English Mode (Both Enconding and uiFont)
    " nnoremap <unique> <M-F1> :set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI<CR>
    " nnoremap <unique> <M-F1> :set guifont=Consolas:h11:cANSI<CR>
    " } DISABLE end 

    " M-F2:  Switch to Chinese Mode (Both Enconding and uiFont)
    nnoremap <unique> <M-F2> :set guifont=NSimSun:h10:cGB2312<CR>

    " M-F3:  Switch to Japanese Mode 
    nnoremap <unique> <M-F3> :set guifont=MS_Gothic:h10:cSHIFTJIS<CR>
else
    " <leader>F1:  Switch to English Mode (Both Enconding and uiFont)
    " nnoremap <unique> <M-F1> :set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI<CR>
    nnoremap <unique> <M-F1> :set guifont=Consolas:h11:cANSI<CR>

    " <leader>F2:  Switch to Chinese Mode (Both Enconding and uiFont)
    nnoremap <unique> <M-F2> :set guifont=NSimSun:h10:cGB2312<CR>

    " <leader>F3:  Switch to Japanese Mode 
    nnoremap <unique> <M-F3> :set guifont=MS_Gothic:h10:cSHIFTJIS<CR>
endif

" map Ctrl-Tab to switch window
nnoremap <unique> <S-Up> <C-W><Up>
nnoremap <unique> <S-Down> <C-W><Down>
nnoremap <unique> <S-Left> <C-W><Left>
nnoremap <unique> <S-Right> <C-W><Right>

" Move in fold
noremap <unique> z<Up> zk
noremap <unique> z<Down> zj
if has("gui_running") "  the <alt> key is only available in gui mode.
    noremap <unique> <M-Up> zk
    noremap <unique> <M-Down> zj
endif

" Easy Diff goto
noremap <unique> <C-Up> [c
noremap <unique> <C-k> [c
noremap <unique> <C-Down> ]c
noremap <unique> <C-j> ]c

" VimTip #412: Easy menu-style switch between files with a simple map
" map <C-b> :buffers<CR>:e #

" Like J, I make a de-joint for command mode
" nmap <C-j> a<CR><ESC>

" Enhance '<' '>' , do not need to reselect the block after shift it.
vnoremap <unique> < <gv
vnoremap <unique> > >gv

" Fold close & Fold open
noremap <unique> <kPlus> zo
noremap <unique> <kMinus> zc

" map Up & Down to gj & gk, helpful for wrap text edit
noremap <unique> <Up> gk
noremap <unique> <Down> gj

" map for completion see :help ins-completion for whole completions
" search tags 
inoremap <unique> <c-]> <C-X><C-]>
" search in current files, preview first. remove the original c-p
inoremap <unique> <c-p> <C-X><C-P>

" VimTip 329: A map for swapping words
" http://vim.sourceforge.net/tip_view.php?tip_id=
" Then when you put the cursor on or in a word, press "\sw", and
" the word will be swapped with the next word.  The words may
" even be separated by punctuation (such as "abc = def").
nnoremap <unique> <silent><leader>sw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o>

"/////////////////////////////////////////////////////////////////////////////
" Command
"/////////////////////////////////////////////////////////////////////////////

" perforce key mapping
" TODO: should go to exSourceControl someday. { 
" let g:proj_run1='!p4 edit %f'
" nmap <Leader>po :silent !p4 edit %<CR>
" nmap <Leader>pr :silent !p4 revert %<CR>
command Checkout silent exec '!p4 edit ' . fnamemodify( bufname('%'), ':p' )
command Revert silent exec '!p4 revert ' . fnamemodify( bufname('%'), ':p' )
command Add silent exec '!p4 add ' . fnamemodify( bufname('%'), ':p' )
command Delete silent exec '!p4 delete ' . fnamemodify( bufname('%'), ':p' )
command Changelist :silent !p4 change
command ShowChangelist :!p4 changes -s pending -u jwu
" } TODO end 

"/////////////////////////////////////////////////////////////////////////////
" Auto Command
"/////////////////////////////////////////////////////////////////////////////

" ------------------------------------------------------------------ 
" Desc: Only do this part when compiled with support for autocommands.
" ------------------------------------------------------------------ 

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
endif " has("autocmd")

" ------------------------------------------------------------------ 
" Desc: Buffer
" ------------------------------------------------------------------ 

au BufNewFile,BufEnter * set cpoptions+=d " NOTE: ctags find the tags file from the current path instead of the path of currect file
au BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full) 
au BufNewFile,BufRead *.avs set syntax=avs " for avs syntax file.

au FileType python call s:CheckIfExpandTab() " if edit python scripts, check if have \t. ( python said: the programme can only use \t or not, but can't use them together )
function s:CheckIfExpandTab()
    let has_noexpandtab = search('^\t','wn')
    let has_expandtab = search('^    ','wn')

    "
    if has_noexpandtab && has_expandtab
        let idx = inputlist ( ["ERROR: current file exists both expand and noexpand TAB, python can only use one of these two mode in one file.\nSelect Tab Expand Type:",
                    \ '1. expand (tab=space, recommended)', 
                    \ '2. noexpand (tab=\t, currently have risk)',
                    \ '3. do nothing (I will handle it by myself)'])
        let tab_space = printf('%*s',&tabstop,'')
        if idx == 1
            let has_noexpandtab = 0
            let has_expandtab = 1
            silent exec '%s/\t/' . tab_space . '/g'
        elseif idx == 2
            let has_noexpandtab = 1
            let has_expandtab = 0
            silent exec '%s/' . tab_space . '/\t/g'
        else
            return
        endif
    endif

    " 
    if has_noexpandtab == 1 && has_expandtab == 0  
        echomsg 'substitute space to TAB...'
        set noexpandtab
        echomsg 'done!'
    elseif has_noexpandtab == 0 && has_expandtab == 1
        echomsg 'substitute TAB to space...'
        set expandtab
        echomsg 'done!'
    else
        " it may be a new file
        " we use original vim setting
    endif
endfunction

" DISABLE { 
" NOTE: may have problem with exUtility
" Change current directory to the file of the buffer ( from Script#65"CD.vim"
" au   BufEnter *   execute ":lcd " . expand("%:p:h") 
" } DISABLE end 

" ------------------------------------------------------------------ 
" Desc: 
" ------------------------------------------------------------------ 

if has("gui_running")
    if has("win32")
        " au GUIEnter * simalt ~x " Maximize window when enter vim
        " set a fixed size of vim
        if exists("+lines")
            set lines=55
        endif
        if exists("+columns")
            set columns=125
        endif
    elseif has("unix")
        " TODO: no way right now
    endif
endif

" ------------------------------------------------------------------ 
" Desc: file types 
" ------------------------------------------------------------------ 

" Disable auto-comment for c/cpp, javascript, c# and vim-script
au FileType c,cpp,javascript set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f:// 
au FileType cs set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f:///,f:// 
au FileType vim set comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",f:\"

"/////////////////////////////////////////////////////////////////////////////
" Plugin Configurations
"/////////////////////////////////////////////////////////////////////////////

" ------------------------------------------------------------------ 
" Desc: exUtility
" ------------------------------------------------------------------ 

" quick substitue h1 -> h2
nnoremap <unique> <silent><leader>sub :%s/<c-r>q/<c-r>w/g<CR><c-o>
vnoremap <unique> <silent><leader>sub  :s/<c-r>q/<c-r>w/g<CR><c-o>

" edit current vimentry
nnoremap <unique> <leader>ve :call exUtility#EditVimEntry ()<CR>

" map for quick add special comments
nnoremap <unique> <leader>ws :SEG<CR>
nnoremap <unique> <leader>wd :DEF<CR>
nnoremap <unique> <leader>we :SEP<CR>
nnoremap <unique> <leader>wc :DEC<CR>
nnoremap <unique> <leader>wh :HEADER<CR>

" F9:  Insert/Remove macro extend ("\") after all the lines of the selection
vnoremap <unique> <F9> :call exUtility#InsertRemoveExtend()<CR>

" F12: Insert '#if 0' and '#endif' between the selection
vnoremap <unique> <F12> :call exUtility#InsertIFZero()<CR>
nnoremap <unique> <F12> :call exUtility#RemoveIFZero()<CR>

" switch between edit and ex-plugin window
nnoremap <unique> <silent><Leader><Tab> :call exUtility#SwitchBuffer()<CR>

" close ex-plugin window when in edit window
nmap <unique> <silent><Leader><ESC> :call exUtility#SwitchBuffer()<CR><ESC>

" change the original file jump method to this one
nnoremap <unique> gf :call exUtility#QuickFileJump()<CR>

" VimTip #401: A mapping for easy switching between buffers
" DISABLE: there has a bug, in window (not fullscree) mode, some times the buffer will jump to other display screen ( if you use double screen ). { 
" nmap <silent> <C-Right> :bn!<CR>
" nmap <silent> <C-Left> :bp!<CR>
" } DISABLE end 
nnoremap <unique> <silent> <C-Right> :call exUtility#GotoBuffer('next')<CR>
nnoremap <unique> <silent> <C-Left> :call exUtility#GotoBuffer('prev')<CR>
nnoremap <unique> <silent> <C-Tab> :call exUtility#SwapToLastEditBuffer()<CR>

" map exUtility#Kwbd(1) to \bd will close buffer and keep window
nnoremap <unique> <Leader>bd :call exUtility#Kwbd(1)<CR>
nnoremap <unique> <C-F4> :call exUtility#Kwbd(1)<CR>

" quick highlight
" NOTE: only gui mode can have alt, in terminal we have to use other mapping
if has("gui_running") " gui mode
    if has ("mac")
        nnoremap <unique> <silent> ¡ :call exUtility#Highlight_Normal(1)<CR>
        nnoremap <unique> <silent> ™ :call exUtility#Highlight_Normal(2)<CR>
        nnoremap <unique> <silent> £ :call exUtility#Highlight_Normal(3)<CR>
        nnoremap <unique> <silent> ¢ :call exUtility#Highlight_Normal(4)<CR>

        vnoremap <unique> <silent> ¡ :call exUtility#Highlight_Visual(1)<CR>
        vnoremap <unique> <silent> ™ :call exUtility#Highlight_Visual(2)<CR>
        vnoremap <unique> <silent> £ :call exUtility#Highlight_Visual(3)<CR>
        vnoremap <unique> <silent> ¢ :call exUtility#Highlight_Visual(4)<CR>

        nnoremap <unique> <silent> º :call exUtility#HighlightCancle(0)<CR>
    else
        nnoremap <unique> <silent> <M-1> :call exUtility#Highlight_Normal(1)<CR>
        nnoremap <unique> <silent> <M-2> :call exUtility#Highlight_Normal(2)<CR>
        nnoremap <unique> <silent> <M-3> :call exUtility#Highlight_Normal(3)<CR>
        nnoremap <unique> <silent> <M-4> :call exUtility#Highlight_Normal(4)<CR>

        vnoremap <unique> <silent> <M-1> :call exUtility#Highlight_Visual(1)<CR>
        vnoremap <unique> <silent> <M-2> :call exUtility#Highlight_Visual(2)<CR>
        vnoremap <unique> <silent> <M-3> :call exUtility#Highlight_Visual(3)<CR>
        vnoremap <unique> <silent> <M-4> :call exUtility#Highlight_Visual(4)<CR>

        nnoremap <unique> <silent> <M-0> :call exUtility#HighlightCancle(0)<CR>
    endif
else " terminal mode
    nnoremap <unique> <silent> <leader>h1 :call exUtility#Highlight_Normal(1)<CR>
    nnoremap <unique> <silent> <leader>h2 :call exUtility#Highlight_Normal(2)<CR>
    nnoremap <unique> <silent> <leader>h3 :call exUtility#Highlight_Normal(3)<CR>
    nnoremap <unique> <silent> <leader>h4 :call exUtility#Highlight_Normal(4)<CR>

    vnoremap <unique> <silent> <leader>h1 :call exUtility#Highlight_Visual(1)<CR>
    vnoremap <unique> <silent> <leader>h2 :call exUtility#Highlight_Visual(2)<CR>
    vnoremap <unique> <silent> <leader>h3 :call exUtility#Highlight_Visual(3)<CR>
    vnoremap <unique> <silent> <leader>h4 :call exUtility#Highlight_Visual(4)<CR>

    nnoremap <unique> <silent> <leader>h0 :call exUtility#HighlightCancle(0)<CR>
endif

nnoremap <unique> <silent> <Leader>0 :call exUtility#HighlightCancle(0)<CR>
nnoremap <unique> <silent> <Leader>1 :call exUtility#HighlightCancle(1)<CR>
nnoremap <unique> <silent> <Leader>2 :call exUtility#HighlightCancle(2)<CR>
nnoremap <unique> <silent> <Leader>3 :call exUtility#HighlightCancle(3)<CR>
nnoremap <unique> <silent> <Leader>4 :call exUtility#HighlightCancle(4)<CR>

" copy only full path name
nnoremap <unique> <silent> <leader>y1 :call exUtility#Yank( fnamemodify(bufname('%'),":p:h") )<CR>
" copy only file name
nnoremap <unique> <silent> <leader>y2 :call exUtility#Yank( fnamemodify(bufname('%'),":p:t") )<CR>
" copy full path + filename
nnoremap <unique> <silent> <leader>y3 :call exUtility#Yank( fnamemodify(bufname('%'),":p") )<CR>
" copy path + filename for code
nnoremap <unique> <silent> <leader>yb :call exUtility#YankBufferNameForCode()<CR>
" copy path for code
nnoremap <unique> <silent> <leader>yp :call exUtility#YankFilePathForCode()<CR>

" VimTip 311: Open the folder containing the currently open file
" http://vim.sourceforge.net/tip_view.php?tip_id=
" 
" Occasionally, on windows, I have files open in gvim, that the folder for 
" that file is not open. This key map opens the folder that contains the 
" currently open file. The expand() is so that we don't try to open the 
" folder of an anonymous buffer, we would get an explorer error dialog in 
" that case.
" 
if has("gui_running")
    if has("win32")
        " Open the folder containing the currently open file. Double <CR> at end
        " is so you don't have to hit return after command. Double quotes are
        " not necessary in the 'explorer.exe %:p:h' section.
        " nnoremap <silent> <C-F5> :if expand("%:p:h") != ""<CR>:!start explorer.exe %:p:h<CR>:endif<CR><CR>

        " explore the vimfile directory
        nnoremap <unique> <silent> <C-F5> :call exUtility#Yank( getcwd() . '\' . g:exES_VimfilesDirName )<CR>
        nnoremap <unique> <silent> <M-F5> :call exUtility#Explore( getcwd() . '\' . g:exES_VimfilesDirName )<CR>
        " explore the cwd directory
        nnoremap <unique> <silent> <C-F6> :call exUtility#Yank(getcwd())<CR>
        nnoremap <unique> <silent> <M-F6> :call exUtility#Explore(getcwd())<CR>
        " explore the diretory current file in
        nnoremap <unique> <silent> <C-F7> :call exUtility#Yank(expand("%:p:h"))<CR>
        nnoremap <unique> <silent> <M-F7> :call exUtility#Explore(expand("%:p:h"))<CR>
    endif
endif

" inherit
nnoremap <unique> <silent> <Leader>gv :call exUtility#ViewInheritsImage()<CR>

" mark (special) text
let g:ex_todo_keyword = 'NOTE REF EXAMPLE SAMPLE CHECK TIPS HINT'
let g:ex_comment_lable_keyword = 'DELME TEMP MODIFY ADD KEEPME DISABLE TEST ' " for editing
let g:ex_comment_lable_keyword .= 'ERROR DEBUG CRASH DUMMY UNUSED TESTME ' " for testing 
let g:ex_comment_lable_keyword .= 'FIXME BUG HACK OPTME HARDCODE REFACTORING DUPLICATE REDUNDANCY PATCH ' " for refactoring

vnoremap <unique> <Leader>mk :MK 
nnoremap <unique> <Leader>mk :call exUtility#RemoveSpecialMarkText() <CR>

" register buffer names of plugins.
let g:ex_plugin_registered_bufnames = ["-MiniBufExplorer-","__Tag_List__","\[Lookup File\]", "\[BufExplorer\]"] 

" register filetypes of plugins.
let g:ex_plugin_registered_filetypes = ["ex_plugin","ex_project","taglist","nerdtree"] 

" default languages
let g:ex_default_langs = ['c', 'cpp', 'c#', 'javascript', 'java', 'shader', 'python', 'vim', 'uc', 'matlab', 'wiki', 'ini', 'make', 'sh', 'batch', 'debug', 'qt', 'swig' ] 

" DISABLE: auto highlight cursor word
" let g:ex_auto_hl_cursor_word = 1

" set exvim language map
call exUtility#AddLangMap ( 'exvim', 'javascript', ['as'] )
call exUtility#AddLangMap ( 'exvim', 'maxscript', ['ms'] )

" To let the extension language works correctly, you need to put toolkit/ctags/.ctags into your $HOME directory
" set ctags language map
" call exUtility#AddLangMap ( 'ctags', 'ini', ['ini'] )
" call exUtility#AddLangMap ( 'ctags', 'uc', ['uc'] )
call exUtility#AddLangMap ( 'ctags', 'maxscript', ['ms'] )

" update custom highlights
function g:ex_CustomHighlight()

    " ======================================================== 
    " ShowMarks
    " ======================================================== 

    " For marks a-z
    hi clear ShowMarksHLl
    hi ShowMarksHLl term=bold cterm=none ctermbg=LightBlue gui=none guibg=LightBlue
    " For marks A-Z
    hi clear ShowMarksHLu
    hi ShowMarksHLu term=bold cterm=bold ctermbg=LightRed ctermfg=DarkRed gui=bold guibg=LightRed guifg=DarkRed
    " For all other marks
    hi clear ShowMarksHLo
    hi ShowMarksHLo term=bold cterm=bold ctermbg=LightYellow ctermfg=DarkYellow gui=bold guibg=LightYellow guifg=DarkYellow
    " For multiple marks on the same line.
    hi clear ShowMarksHLm
    hi ShowMarksHLm term=bold cterm=none ctermbg=LightBlue gui=none guibg=SlateBlue

    " ======================================================== 
    " MiniBufExplorer
    " ======================================================== 

    " for buffers that have NOT CHANGED and are NOT VISIBLE.
    hi MBENormal ctermbg=LightGray ctermfg=DarkGray guibg=LightGray guifg=DarkGray
    " for buffers that HAVE CHANGED and are NOT VISIBLE
    hi MBEChanged ctermbg=Red ctermfg=DarkRed guibg=Red guifg=DarkRed
    " buffers that have NOT CHANGED and are VISIBLE
    hi MBEVisibleNormal term=bold cterm=bold ctermbg=Gray ctermfg=Black gui=bold guibg=Gray guifg=Black
    " buffers that have CHANGED and are VISIBLE
    hi MBEVisibleChanged term=bold cterm=bold ctermbg=DarkRed ctermfg=Black gui=bold guibg=DarkRed guifg=Black

    " ======================================================== 
    " TagList
    " ======================================================== 

    " TagListTagName  - Used for tag names
    hi MyTagListTagName term=bold cterm=none ctermfg=Black ctermbg=DarkYellow gui=none guifg=Black guibg=#ffe4b3
    " TagListTagScope - Used for tag scope
    hi MyTagListTagScope term=NONE cterm=NONE ctermfg=Blue gui=NONE guifg=Blue 
    " TagListTitle    - Used for tag titles
    hi MyTagListTitle term=bold cterm=bold ctermfg=DarkRed ctermbg=LightGray gui=bold guifg=DarkRed guibg=LightGray 
    " TagListComment  - Used for comments
    hi MyTagListComment ctermfg=DarkGreen guifg=DarkGreen 
    " TagListFileName - Used for filenames
    hi MyTagListFileName term=bold cterm=bold ctermfg=Black ctermbg=LightBlue gui=bold guifg=Black guibg=LightBlue

    " ======================================================== 
    " special color settings 
    " ======================================================== 

    if exists('g:colors_name') && g:colors_name == 'ex_lightgray'
        " ex plugins
        hi ex_SynSearchPattern gui=bold guifg=DarkRed guibg=Gray term=bold cterm=bold ctermfg=DarkRed ctermbg=Gray
        hi exMH_GroupNameEnable term=bold cterm=bold ctermfg=DarkRed ctermbg=Gray gui=bold guifg=DarkRed guibg=Gray
        hi exMH_GroupNameDisable term=bold cterm=bold ctermfg=Red ctermbg=DarkGray gui=bold guifg=DarkGray guibg=Gray

        " other plugins
        hi MBEVisibleNormal term=bold cterm=bold ctermbg=DarkGray ctermfg=Black gui=bold guibg=DarkGray guifg=Black
        hi MBENormal ctermbg=Gray ctermfg=DarkGray guibg=Gray guifg=DarkGray
        hi MyTagListTitle term=bold cterm=bold ctermfg=DarkRed ctermbg=Gray gui=bold guifg=DarkRed guibg=Gray 
    endif

endfunction

" ------------------------------------------------------------------ 
" Desc: exTagSelect
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>ts :ExtsSelectToggle<CR>
nnoremap <unique> <silent> <Leader>tg :ExtsGoDirectly<CR>
nnoremap <unique> <silent> <Leader>] :ExtsGoDirectly<CR>

let g:exTS_backto_editbuf = 0
let g:exTS_close_when_selected = 1
let g:exTS_window_direction = 'bel'

" ------------------------------------------------------------------ 
" Desc: exGlobalSearch
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>gs :ExgsSelectToggle<CR>
nnoremap <unique> <silent> <Leader>gq :ExgsQuickViewToggle<CR>
nnoremap <unique> <silent> <Leader>gg :ExgsGoDirectly<CR>
nnoremap <unique> <silent> <Leader>n :ExgsGotoNextResult<CR>
nnoremap <unique> <silent> <Leader>N :ExgsGotoPrevResult<CR>
nnoremap <unique> <Leader><S-f> :GS 

let g:exGS_backto_editbuf = 0
let g:exGS_close_when_selected = 0
let g:exGS_window_direction = 'bel'
let g:exGS_auto_sort = 1
let g:exGS_lines_for_autosort = 200

" ------------------------------------------------------------------ 
" Desc: exSymbolTable
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>ss :ExslSelectToggle<CR>
nnoremap <unique> <silent> <Leader>sq :ExslQuickViewToggle<CR>
nnoremap <unique> <silent> <Leader>sg :ExslGoDirectly<CR>
" NOTE: the / can be mapped to other script ( for example exSearchComplete ), so here use nmap instead of nnoremap 

if has("gui_running") "  the <alt> key is only available in gui mode.
    if has ("mac")
        nmap <unique> Ò :ExslQuickSearch<CR>/
    else
        nmap <unique> <M-L> :ExslQuickSearch<CR>/
    endif
endif

let g:exSL_SymbolSelectCmd = 'TS'

" ------------------------------------------------------------------ 
" Desc: exJumpStack 
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>tt :ExjsToggle<CR>
nnoremap <unique> <silent> <Leader>tb :BackwardStack<CR>
nnoremap <unique> <silent> <Leader>tf :ForwardStack<CR>
nnoremap <unique> <silent> <BS> :BackwardStack<CR>

if has("gui_running") "  the <alt> key is only available in gui mode.
    noremap <unique> <M-Left> :BackwardStack<CR>
    noremap <unique> <M-Right> :ForwardStack<CR>
endif

" ------------------------------------------------------------------ 
" Desc: exCscope
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <F2> :CSIC<CR>
nnoremap <unique> <silent> <Leader>ci :CSID<CR>
nnoremap <unique> <silent> <F3> :ExcsParseFunction<CR>
nnoremap <unique> <silent> <Leader>cd :CSDD<CR>
nnoremap <unique> <silent> <Leader>cc :CSCD<CR>
nnoremap <unique> <silent> <Leader>cs :ExcsSelectToggle<CR>
nnoremap <unique> <silent> <Leader>cq :ExcsQuickViewToggle<CR>

let g:exCS_backto_editbuf = 0
let g:exCS_close_when_selected = 0
let g:exCS_window_direction = 'bel'
let g:exCS_window_width = 48

" ------------------------------------------------------------------ 
" Desc: exQuickFix
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <leader>qf :ExqfSelectToggle<CR>
nnoremap <unique> <silent> <leader>qq :ExqfQuickViewToggle<CR>

let g:exQF_backto_editbuf = 0
let g:exQF_close_when_selected = 0
let g:exQF_window_direction = 'bel'

" ------------------------------------------------------------------ 
" Desc: exMacroHighlight
" ------------------------------------------------------------------ 

nnoremap <unique> <silent> <Leader>aa :ExmhSelectToggle<CR>
nnoremap <unique> <silent> <Leader>ae :ExmhHL 1 <CR>
nnoremap <unique> <silent> <Leader>ad :ExmhHL 0 <CR>

" ------------------------------------------------------------------ 
" Desc: exProject
" ------------------------------------------------------------------ 

" NOTE: the / can be mapped to other script ( for example exSearchComplete ), so here use nmap instead of nnoremap 
" NOTE: M-O equal to A-S-o, the S-o equal to O
if has("gui_running") "  the <alt> key is only available in gui mode.
    if has ("mac")
        nmap <unique> Ø :EXProject<CR>:redraw<CR>/
        nnoremap <unique> <silent> ∏ :EXProject<CR>
    else
        nmap <unique> <M-O> :EXProject<CR>:redraw<CR>/
        nnoremap <unique> <silent> <M-P> :EXProject<CR>
    endif
endif
nnoremap <unique> <leader>ff :EXProject<CR>:redraw<CR>/\[\l*\]\zs.*
nnoremap <unique> <leader>fd :EXProject<CR>:redraw<CR>/\[\u\]\zs.*
nnoremap <unique> <leader>fc :ExpjGotoCurrentFile<CR>

let g:exPJ_backto_editbuf = 1
let g:exPJ_close_when_selected = 0
let g:exPJ_window_width = 30
let g:exPJ_window_width_increment = 50

" ------------------------------------------------------------------ 
" Desc: exBufExplorer 
" ------------------------------------------------------------------ 

" NOTE: the / can be mapped to other script ( for example exSearchComplete ), so here use nmap instead of nnoremap 
if has("gui_running") "  the <alt> key is only available in gui mode.
    if has ("mac")
        nmap <unique> ı :EXBufExplorer<CR>:redraw<CR>/
    else
        nmap <unique> <M-B> :EXBufExplorer<CR>:redraw<CR>/
    endif
endif
nnoremap <unique> <silent> <leader>bs :EXBufExplorer<CR>
nnoremap <unique> <leader>bk :EXAddBookmarkDirectly<CR>

let g:exBE_backto_editbuf = 0
let g:exBE_close_when_selected = 0

" ------------------------------------------------------------------ 
" Desc: exMarksBrowser 
" ------------------------------------------------------------------ 

nnoremap <unique> <leader>ms :ExmbToggle<CR>

let g:exMB_backto_editbuf = 0
let g:exMB_close_when_selected = 0
let g:exMB_window_direction = 'bel'

" ------------------------------------------------------------------ 
" Desc: exEnvironmentSetting
" NOTE: The exEnvironmentSetting must put at the end of the plugin 
"       settings. It may update the default settings of plugin above
" ------------------------------------------------------------------ 

"
let g:exES_project_cmd = 'EXProject'

" NOTE: if you have different programme path and settings, pls create your own vimrc under $HOME, and define these variables by yourself.
"       And don't forget sourced this rc at the end. 
"       web browser option: 'c:\Program Files\Mozilla Firefox\firefox.exe'
if has("gui_running")
    if has("win32")
        let g:exES_WebBrowser = 'c:\Documents and Settings\jie_wu\Local Settings\Application Data\Google\Chrome\Application\chrome.exe'
        let g:exES_ImageViewer = 'd:\app\IrfanView\i_view32.exe'
    elseif has("unix")
        let g:exES_WebBrowser = 'firefox'
    endif
endif

" exEnvironmentSetting post update
" NOTE: this is a post update environment function used for any custom environment update 
function g:exES_PostUpdate()

    " set lookup file plugin variables
	if exists( 'g:exES_LookupFileTag' )
        let g:LookupFile_TagExpr='"'.g:exES_LookupFileTag.'"'
        if exists(':LUCurFile')
            " NOTE: the second <CR>, if only one file, will jump to it directly.
            unmap gf
            nnoremap <unique> <silent> gf :LUCurFile<CR>
        endif
    endif

	" set visual_studio plugin variables
	if exists( 'g:exES_vsTaskList' )
		let g:visual_studio_task_list = g:exES_vsTaskList
	endif
	if exists( 'g:exES_vsOutput' )
		let g:visual_studio_output = g:exES_vsOutput
	endif
	if exists( 'g:exES_vsFindResult1' )
		let g:visual_studio_find_results_1 = g:exES_vsFindResult1
	endif
	if exists( 'g:exES_vsFindResult2' )
		let g:visual_studio_find_results_2 = g:exES_vsFindResult2
	endif

    " set vimwiki
    if exists( 'g:exES_wikiHome' )
        " clear the list first
        if exists( 'g:vimwiki_list' ) && !empty(g:vimwiki_list)
            silent call remove( g:vimwiki_list, 0, len(g:vimwiki_list)-1 )
        endif

        " assign vimwiki pathes, 
        " NOTE: vimwiki need full path.
        let g:vimwiki_list = [ { 'path': fnamemodify(g:exES_wikiHome,":p"), 
                    \ 'path_html': fnamemodify(g:exES_wikiHomeHtml,":p"),
                    \ 'html_header': fnamemodify(g:exES_wikiHtmlHeader,":p") } ]

        " create vimwiki files
        call exUtility#CreateVimwikiFiles ()
    endif
endfunction

" ------------------------------------------------------------------ 
" Desc: TagList
" ------------------------------------------------------------------ 

" F4:  Switch on/off TagList
nnoremap <unique> <silent> <F4> :TlistToggle<CR>

"let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool 
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself 
let Tlist_Use_Right_Window = 1 " split to the right side of the screen 
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 0 " Close the taglist window when a file or tag is selected.
let Tlist_BackToEditBuffer = 0 " If no close on select, let the user choose back to edit buffer or not
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 40
let Tlist_Compact_Format = 1 " do not show help
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber]

" let taglist support shader language as c-like language
let tlist_hlsl_settings = 'c;d:macro;g:enum;s:struct;u:union;t:typedef;v:variable;f:function'

" ------------------------------------------------------------------ 
" Desc: MiniBufExpl
" ------------------------------------------------------------------ 

let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines) 
let g:miniBufExplModSelTarget = 1 " If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer. 
let g:miniBufExplMaxSize = 1 " <max lines: default 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers. 
" comment out this, when we open a single file by we, we don't need minibuf opened. Minibu always open in exDev mode, in EnvironmentUpdate 
" let g:miniBufExplorerMoreThanOne = 0 " Setting this to 0 will cause the MBE window to be loaded even

"let g:miniBufExplForceSyntaxEnable = 1 " There is a VIM bug that can cause buffers to show up without their highlighting. The following setting will cause MBE to
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplMapWindowNavArrows = 1

" ------------------------------------------------------------------ 
" Desc: OmniCppComplete
" ------------------------------------------------------------------ 

" set Ctrl+j in insert mode, like VS.Net
imap <unique> <C-j> <C-X><C-O>
" :inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>" 

" set completeopt as don't show menu and preview
au FileType c,cpp,hlsl set completeopt=menuone

" use global scope search
let OmniCpp_GlobalScopeSearch = 1

" 0 = namespaces disabled
" 1 = search namespaces in the current buffer
" 2 = search namespaces in the current buffer and in included files
let OmniCpp_NamespaceSearch = 1

" 0 = auto
" 1 = always show all members
let OmniCpp_DisplayMode = 1

" 0 = don't show scope in abbreviation
" 1 = show scope in abbreviation and remove the last column
let OmniCpp_ShowScopeInAbbr = 0

" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
" 0 = don't display prototype in abbreviation
" 1 = display prototype in abbreviation
let OmniCpp_ShowPrototypeInAbbr = 1

" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
" 0 = hide access
" 1 = show access
let OmniCpp_ShowAccess = 1

" This option can be use if you don't want to parse using namespace declarations in included files and want to add namespaces that are always used in your project.
let OmniCpp_DefaultNamespaces = ["std"]

" Complete Behaviour
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0

" When 'completeopt' does not contain "longest", Vim automatically select the first entry of the popup menu. You can change this behaviour with the OmniCpp_SelectFirstItem option.
let OmniCpp_SelectFirstItem = 0

" ------------------------------------------------------------------ 
" Desc: pythoncomplete
" ------------------------------------------------------------------ 

" DISABLE: au FileType python set completeopt=menuone,preview
" NOTE: the preview can show the internal document in a preview window, but I don't think it have too much help
au FileType python set completeopt=menuone

" ------------------------------------------------------------------ 
" Desc: EnhCommentify
" ------------------------------------------------------------------ 

let g:EnhCommentifyFirstLineMode='yes'
let g:EnhCommentifyRespectIndent='yes'
let g:EnhCommentifyUseBlockIndent='yes'
let g:EnhCommentifyAlignRight = 'yes'
let g:EnhCommentifyPretty = 'yes'
let g:EnhCommentifyBindInNormal = 'no'
let g:EnhCommentifyBindInVisual = 'no'
let g:EnhCommentifyBindInInsert = 'no'

" NOTE: VisualComment,Comment,DeComment are plugin mapping(start with <Plug>), so can't use remap here
vmap <unique> <F11> <Plug>VisualComment
nmap <unique> <F11> <Plug>Comment
imap <unique> <F11> <ESC><Plug>Comment
vmap <unique> <C-F11> <Plug>VisualDeComment
nmap <unique> <C-F11> <Plug>DeComment
imap <unique> <C-F11> <ESC><Plug>DeComment

" ======================================================== 
"  add new languages for comment
" ======================================================== 

function EnhCommentifyCallback(ft)
    " for hlsl, swig, c
    if a:ft =~ '^\(hlsl\|swig\|c\)$' " NOTE: we have to rewrite the c comment behavior. 
        let b:ECcommentOpen = '//'
        let b:ECcommentClose = ''
    elseif a:ft == 'snippet' " for snippet
        let b:ECcommentOpen = '#'
        let b:ECcommentClose = ''
    elseif a:ft == 'maxscript' " for maxscript
        let b:ECcommentOpen = '--'
        let b:ECcommentClose = ''
    endif
endfunction
let g:EnhCommentifyCallbackExists = 'Yes'

" ------------------------------------------------------------------ 
" Desc: ShowMarks
" ------------------------------------------------------------------ 

let g:showmarks_enable = 1
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 0 

" quick remove mark
" nmap <F9> \mh

" ------------------------------------------------------------------ 
" Desc: LookupFile 
" ------------------------------------------------------------------ 

if has("gui_running") "  the <alt> key is only available in gui mode.
    if has ("mac")
        nnoremap <unique> ˆ :LUTags<CR>
    else
        nnoremap <unique> <M-I> :LUTags<CR>
    endif
endif
nnoremap <unique> <leader>lf :LUTags<CR>
nnoremap <unique> <leader>lb :LUBufs<CR>
nnoremap <unique> <silent> <Leader>ll :LUCurWord<CR>

let g:LookupFile_TagExpr = ''
let g:LookupFile_MinPatLength = 3
let g:LookupFile_PreservePatternHistory = 0
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_AllowNewFiles = 0
let g:LookupFile_smartcase = 1
let g:LookupFile_EscCancelsPopup = 1

" ------------------------------------------------------------------ 
" Desc: VimWiki 
" ------------------------------------------------------------------ 

map <silent><unique> <Leader>wt <Plug>VimwikiTabGoHome
map <silent><unique> <Leader>wq <Plug>VimwikiUISelect
map <silent><unique> <Leader>ww <Plug>VimwikiGoHome

" vimwiki file process
au FileType vimwiki command! W call exUtility#SaveAndConvertVimwiki(0)
au FileType vimwiki command! WA call exUtility#SaveAndConvertVimwiki(1)
au FileType rst command! W call exUtility#SphinxMake('html')

let g:vimwiki_camel_case = 0
let g:vimwiki_hl_headers = 1

" ------------------------------------------------------------------ 
" Desc: snipMate
" ------------------------------------------------------------------ 

let g:snips_author = g:ex_usr_name
let g:snippets_dir = g:ex_toolkit_path . '/snippets/'

" ------------------------------------------------------------------ 
" Desc: NERD_tree 
" ------------------------------------------------------------------ 

let g:NERDTreeWinSize = exists('g:exPJ_window_width') ? g:exPJ_window_width : 30 

" ------------------------------------------------------------------ 
" Desc: zencoding 
" ------------------------------------------------------------------ 

let g:user_zen_leader_key = '<c-j>'

" ------------------------------------------------------------------ 
" Desc: surround 
" 'sb' for block
" 'si' for an if statement
" 'sw' for a with statement
" 'sc' for a comment
" 'sf' for a for statement
" ------------------------------------------------------------------ 

" DISABLE { 
" let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
" let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
" let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
" let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
" let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"
" } DISABLE end 

"/////////////////////////////////////////////////////////////////////////////
" Other settings
"/////////////////////////////////////////////////////////////////////////////

