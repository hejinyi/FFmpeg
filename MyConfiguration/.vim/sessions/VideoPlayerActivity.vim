" ~/.vim/sessions/VideoPlayerActivity.vim:
" Vim session script.
" Created by session.vim 2.4.9 on 27 November 2013 at 09:11:27.
" Open this file in Vim and run :source % to restore your session.

set guioptions=aegimrLtT
silent! set guifont=
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'light'
	set background=light
endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/amlogic
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +99 vendor/jamdeo/tv/apps/MediaCenter/src/com/jamdeo/tv/mediacenter/VideoPlayerActivity.java
badd +0 ~/amlogic/vendor/jamdeo/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/app/ApplicationPanelActivity.java
" args vendor/jamdeo/tv/apps/MediaCenter/src/com/jamdeo/tv/mediacenter/VideoPlayerActivity.java
edit ~/amlogic/vendor/jamdeo/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/app/ApplicationPanelActivity.java
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 2 + 24) / 48)
exe 'vert 1resize ' . ((&columns * 34 + 86) / 172)
exe '2resize ' . ((&lines * 43 + 24) / 48)
exe 'vert 2resize ' . ((&columns * 34 + 86) / 172)
exe 'vert 3resize ' . ((&columns * 137 + 86) / 172)
" argglobal
enew
file \[Buf\ List]
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
" argglobal
enew
" file __Tag_List__
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=9999
setlocal fml=0
setlocal fdn=20
setlocal fen
wincmd w
" argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
70
silent! normal zo
146
silent! normal zo
70
silent! normal zo
let s:l = 146 - ((50 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
146
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 2 + 24) / 48)
exe 'vert 1resize ' . ((&columns * 34 + 86) / 172)
exe '2resize ' . ((&lines * 43 + 24) / 48)
exe 'vert 2resize ' . ((&columns * 34 + 86) / 172)
exe 'vert 3resize ' . ((&columns * 137 + 86) / 172)
tabnext 1
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

tabnext 1
2wincmd w
let s:bufnr_save = bufnr("%")
let s:cwd_save = getcwd()
Tlist
if !getbufvar(s:bufnr_save, '&modified')
  let s:wipebuflines = getbufline(s:bufnr_save, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:bufnr_save
  endif
endif
execute "cd" fnameescape(s:cwd_save)
1resize 2|vert 1resize 34|2resize 43|vert 2resize 34|3resize 46|vert 3resize 137|
tabnext 1
3wincmd w
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
