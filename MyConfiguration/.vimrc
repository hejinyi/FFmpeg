" Provided by Vim --------------------{{{
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
" else
" set backup		" keep a backup file
" endif
set nobackup
set history=700		" keep 50 lines of command line history
set autoread
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
set mouse=v

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
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
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
" }}}


" Added by gary 

" Vimscript file settings ---------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"  }}}
set foldmethod=marker

" Vim enviaronment settings --------------------{{{"
" Set number real
set nu
" Set mapleader
let mapleader=","
" Set maplocalleader
let maplocalleader="."

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs
set smarttab
" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

if filereadable("tags")
   set tags=tags 
endif

set cursorline
hi CursorLine  cterm=NONE   ctermbg=lightmagenta ctermfg=white
hi CursorColumn cterm=NONE ctermbg=lightmagenta ctermfg=white

" ignorecase
set ic

" }}}

" My shortcut key --------------------{{{"
" Fast reloading of the .vimrc
nnoremap <silent> <leader>ca :!/home/gary/Myscript/acc.sh<cr>
nnoremap <silent> <leader>cl :!/home/gary/Myscript/acc.sh logcat<cr>
nnoremap <silent> <leader>ss :source $MYVIMRC<cr>
nnoremap <silent> <leader>cp :!cp % /tmp<cr>
" Fast editing of .vimrc
nnoremap <silent> <leader>ee :vsplit $MYVIMRC<cr>
" When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

nnoremap <silent> <leader>ma :set mouse=a<cr>
nnoremap <silent> <leader>mv :set mouse=v<cr>
nnoremap <silent> <leader>nh :nohl<cr>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap ] <C-]>
nnoremap [ <C-o>
nnoremap <CR> G
nnoremap <silent> q :q!<cr>

imap jk <esc>
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
" }}}

" My shortcut for text manipulation --------------------{{{
" shortcut for delete manipulate
nnoremap <silent> <leader>d" F"l<c-v>f"hd
" add ' for a world
nnoremap <silent> <leader>' viw<esc>a'<esc>hbi'<esc>lel
" add " for a word
nnoremap <silent> <leader>" viw<esc>a"<esc>hbi"<esc>lel
" add {} for a word
nnoremap <silent> <leader>{} viw<esc>a}<esc>hbi{<esc>lel
" copy a word
nnoremap <silent> <leader>wy viwy
" copy the function name
nnoremap <silent> <leader>fy F<space>lvf)y
" copy a word
nnoremap <buffer> <localleader>wy viwy
" copy the function name
nnoremap <buffer> <localleader>fy F<space>lvf)y
" Add marker for fold
nnoremap <silent> <leader>{ O<esc>0i"  --------------------{{{<esc>0l
nnoremap <silent> <leader>} o<esc>0i" }}}<esc>
" }}}

augroup programlanguagesettings
    autocmd!
" settings for java ---------------{{{ 
    autocmd FileType java setlocal omnifunc=javacomplete#Complete 
    autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo 
    autocmd FileType java nnoremap <buffer> <localleader>c I//<space><esc>
    autocmd FileType java nnoremap <buffer> <localleader>cc ^3x
"    autocmd FileType java nnoremap <buffer> <localleader>d oLog.d("<esc>"%pF/vF"ld$a", "*****##### Enter <esc>2F"hvF"ly$pvF.ldk$F)v%F<space>lyj$p$a #####*****");<esc>k0f{%O<esc>j$a<space><esc>F}%jyyk0f{%kp03f"fEvf<space>hdiLeave<esc>j$x%^
    autocmd FileType java nnoremap <silent> <localleader>ld4 :!/home/gary/Myscript/LogHelpler_release_4.sh %<cr> 
    autocmd FileType java nnoremap <silent> <localleader>lc4 :!/home/gary/Myscript/LogHelpler_release_4.sh % "clean"<cr> 
    autocmd FileType java nnoremap <silent> <localleader>ld3 :!/home/gary/Myscript/LogHelpler_release_3.sh %<cr> 
    autocmd FileType java nnoremap <silent> <localleader>lc3 :!/home/gary/Myscript/LogHelpler_release_3.sh % "clean"<cr> 
    autocmd FileType java nnoremap <silent> <localleader>d oLog.d("hejinyi", "");<esc>$F"
    autocmd FileType java inoreabbrev <buffer> if. if () {<cr><cr>}<esc>2k$F(l
    autocmd FileType java inoreabbrev <buffer> System. System.out.println("");<esc>2F"
    "autocmd FileType java setlocal foldmethod=syntax
    autocmd FileType java inoreabbrev <buffer> findView. findViewById(R.id.);<esc>F)
    "autocmd FileType java inoremap <silent> ( ()<esc>i
    "autocmd FileType java inoremap <silent> " ""<esc>i
    "autocmd FileType java inoremap <silent> ' ''<esc>i
    "autocmd FileType java inoremap <silent> { {<cr>}<esc>O
" }}}
" settings for bash script --------------------{{{
    autocmd FileType sh nnoremap <buffer> <localleader>c I#<space><esc>
    autocmd FileType sh nnoremap <buffer> <localleader>cc ^2x
    autocmd FileType sh inoreabbrev <buffer> while. while [   ]<cr>do<cr><cr>done<esc>3k$F[ll
    autocmd FileType sh inoreabbrev <buffer> until. until [   ]<cr>do<cr><cr>done<esc>3k$F[ll
    autocmd FileType sh inoreabbrev <buffer> if. if [   ]; then<cr><cr>fi<esc>2k$F[ll
    autocmd FileType sh inoreabbrev <buffer> basp.  <esc>ggO#!/bin/bash<cr>#<cr># Program:<cr>#<cr>#<cr># History:<cr>#<tab><esc>:read !Getdateforvim.sh<cr>kJA<tab>gary<tab>First release<cr>#<cr><cr>export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"<esc>4GA<tab>This script is used to <esc>2h
" }}}
" settings for xml --------------------{{{
    autocmd FileType xml nnoremap <buffer> <localleader>c I<!--<space><esc>A<space>--><esc>
    autocmd FileType xml nnoremap <buffer> <localleader>cc ^5x$3Xx
    autocmd FileType xml inoreabbrev <buffer> xml. <?xml version="1.0" encoding="utf-8"?><esc>
    autocmd FileType xml inoreabbrev <buffer> LinearLayout. <LinearLayout<cr>xmlns:android="http://schemas.android.com/apk/res/android"<cr>android:orientation="vertical"<cr>android:layout_width="match_parent"<cr>android:layout_height="match_parent"<cr>><cr></LinearLayout><esc>k0
    autocmd FileType xml inoreabbrev <buffer> TableLayout. <TableLayout<cr>xmlns:android="http://schemas.android.com/apk/res/android"<cr>android:orientation="vertical"<cr>android:layout_width="match_parent"<cr>android:layout_height="match_parent"<cr>><cr></TableLayout><esc>k0
    autocmd FileType xml inoreabbrev <buffer> FrameLayout. <FrameLayout<cr>xmlns:android="http://schemas.android.com/apk/res/android"<cr>android:orientation="vertical"<cr>android:layout_width="match_parent"<cr>android:layout_height="match_parent"<cr>><cr></FrameLayout><esc>k0
    autocmd FileType xml inoreabbrev <buffer> TableRow. <TableRow><cr><cr></TableRow><esc>k
    autocmd FileType xml inoreabbrev <buffer> resources. <resources><cr></resources><esc>k0
    autocmd FileType xml inoreabbrev <buffer> ScrollView. <ScrollView<cr>xmlns:android="http://schemas.android.com/apk/res/android"<cr>android:layout_width="fill_parent"<cr>android:layout_height="fill_parent"><cr></ScrollView><esc>k0
    autocmd FileType xml inoreabbrev <buffer> TextView. <TextView<cr>android:id="@+id/"<cr>android:layout_width="fill_parent"<cr>android:layout_height="wrap_content"<cr>/><esc>3k0f/
    autocmd FileType xml inoreabbrev <buffer> EditText. <EditText<cr>android:id="@+id/"<cr>android:layout_width="fill_parent"<cr>android:layout_height="wrap_content"<cr>/><esc>3k0f/
    autocmd FileType xml inoreabbrev <buffer> Button. <Button<cr>android:id="@+id/"<cr>android:layout_width="fill_parent"<cr>android:layout_height="wrap_content"<cr>/><esc>3k0f/
    autocmd FileType xml inoreabbrev <buffer> VideoView. <VideoView<cr>android:id="@+id/"<cr>android:layout_width="fill_parent"<cr>android:layout_height="wrap_content"<cr>/><esc>3k0f/
    autocmd FileType xml inoreabbrev <buffer> string. <string name=""></string><esc>F"hh
    autocmd FileType xml inoreabbrev <buffer> color. <color name=""></color><esc>F"hh
" autocmd FileType xml inoreabbrev <buffer> layoutxml <?xml version="1.0" encoding="utf-8"?><cr><  xmlns:android="http://schemas.android.com/apk/res/android"<cr><cr></><esc>0i<tab>android:layout_width="fill_parent"<cr><esc>0i<tab>android:layout_height=:fill_parent"<esc>2k^l
" autocmd FileType xml inoreabbrev <buffer> <lt>TableLayout <lt>TableLayout<cr><tab>android:layout_width=""<cr>android:layout_height=""
" }}}
augroup END

" My abbreviation --------------------{{{
iabbrev waht what
iabbrev tehn then
iabbrev taht that
inoreabbrev myxml <?xml version="1.0" encoding="utf-8"?>
iabbrev mysig -- <cr>Thanks.<cr>贺金义 Gary Ho<cr><cr>---------------------------------------------------------<cr>海信集团重点实验室Jamdeo所 中国山东青岛市市南区江西路11号<cr>办公电话:+86-532-8087 6410<cr>手机:+86 158-6557-8772<cr>公司网址:www.hisense.com<cr><cr>Hisense Key Lab, Jamdeo<cr>No. 11 Jiangxi Road, Qingdao, Shangdong, P. R. China<cr>Office Tele:+86-532-8087 6410<cr>Mobile:+86 158-6557-8772<cr>Web page: www.hisense.com
" }}}

" Taglist settings --------------------{{{
nnoremap <silent> <F9> :TlistToggle<cr>
let Tlist_Ctags_Cmd='/usr/bin/ctags'    " Set the location of ctags command
let Tlist_Show_One_File=1   " Only display the tags of current file
let Tlist_Exit_OnlyWindow=1     " Quit vim if the taglist window is the last window
let Tlist_Use_SingleClick=1     " One click to go to the clicked tag
let Tlist_Use_Right_Window=1    " Display the taglist window at the right window
let Tlist_WinWidth=31
" }}}

" Netrw setting --------------------{{{
let g:netrw_winsize=31
nnoremap <silent> <leader>fe :Sexplore!<cr>
" }}}

" BufExplorer settings --------------------{{{
let g:bufExplorerDefaultHelp=0  " Do not show default help
let g:bufExplorerShowRelativePath=1  " Show relative paths 
let g:bufExplorerSortBy='mru'  " Sort by most recently used
let g:bufExplorerSplitRight=0  " Split left
let g:bufExplorerSplitVertical=1  " Split vertically
let g:bufExplorerSplitVertSize=31  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window
autocmd BufWinEnter \[Buf\ List\] setl nonumber
" }}}

" winManager settings --------------------{{{
let g:winManagerWindowLayout="BufExplorer,FileExplorer|TagList"
let g:winManagerWidth=31
let g:defaultExplorer=0
nnoremap <C-W><C-F> :FirstExplorerWindow<cr>
nnoremap <C-W><C-B> :BottomExplorerWindow<cr>
nnoremap <silent> <leader>wm :source $MYVIMRC<cr>:WMToggle<cr>
" }}}

" lookupfile settings --------------------{{{
let g:LookupFile_MinPatLength=4	" begin to lookup from at least 2 characters
let g:LookupFile_PreserveLastPattern=0	" don't save the last lookuped string
let g:LookupFile_PreservePatternHistory=1	" save the lookup history
let g:LookupFile_AlwaysAcceptFirst=0	" open the first item while hit return
let g:LookupFile_AllowNewFiles=0	" don't create the file that not exit
let g:LookupFile_FileFilter = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.war$\|\.ear$'
if filereadable("./hejinyiFilenametags")
		let g:LookupFile_TagExpr='"./hejinyiFilenametags"'
endif
" map LookupFile to ,1t
nnoremap <silent> <leader>lt :LUTags<cr>
" map LUBufs to ,lb
nnoremap <silent> <leader>lb :LUBufs<cr>
" map LUWalk to ,lw
nnoremap <silent> <leader>1w :LUWalk<cr>
" lookup file with ignore case  
function! LookupFile_IgnoreCaseFunc(pattern)  
    let _tags = &tags  
    try  
        let &tags = eval(g:LookupFile_TagExpr)  
        let newpattern = '\c' . a:pattern  
        let tags = taglist(newpattern)  
    catch  
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE  
        return ""  
    finally  
        let &tags = _tags  
    endtry  
    " Show the matches for what is typed so far.  
    let files = map(tags, 'v:val["filename"]')  
    return files  
endfunction  
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'   
" }}}

" cscope settings --------------------{{{
if has("cscope")
		set csprg=/usr/bin/cscope
		set csto=1
		set cst
		set nocsverb
		" add any database in current directory
		if filereadable("cscope.out")
				cs add cscope.out
		endif
		set csverb
endif

"nnoremap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nnoremap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nnoremap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nnoremap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nnoremap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nnoremap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nnoremap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-s> :cs find s 
"nnoremap <C-g> :cs find g 
nnoremap <C-c> :cs find c 
nnoremap <C-t> :cs find t 
nnoremap <C-e> :cs find e 
nnoremap <C-f> :cs find f 
nnoremap <C-i> :cs find i 
" }}}

" Amlogic project settings --------------------{{{
" execute project related comfiguration in current directory
if filereadable("Amlogic.vim")
    source Amlogic.vim
endif
set path+='/home/gary/workspace/Amlogic/**'
" }}}

" supertab settings --------------------{{{
let g:SuperTabRetainCompletionType=1
let g:SuperTabDefaultCompletionType="<C-X><C-N>"
"inoremap <leader><tab> <C-X><C-O><C-P>
inoremap <leader><tab> <C-X><C-O>
" }}}

" session.vim settings --------------------{{{
let g:session_autosave='no'
" }}}

" omnicppcomplete settings --------------------{{{
set completeopt=menu,menuone  
let OmniCpp_MayCompleteDot=1    "打开  . 操作符
let OmniCpp_MayCompleteArrow=1  "打开 -> 操作符
let OmniCpp_MayCompleteScope=1  "打开 :: 操作符
let OmniCpp_NamespaceSearch=1   "打开命名空间
let OmniCpp_GlobalScopeSearch=1  
let OmniCpp_DefaultNamespace=["std"]  
let OmniCpp_ShowPrototypeInAbbr=1  "打开显示函数原型
let OmniCpp_SelectFirstItem = 2    "自动弹出时自动跳至第一个
" }}}
" Added by gary 
