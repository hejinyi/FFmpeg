" ~/.vim/sessions/AudioManagersync.vim:
" Vim session script.
" Created by session.vim 2.4.9 on 07 March 2014 at 22:34:07.
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
cd ~/k370_work
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1842 ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/policy/src_tv/com/android/internal/policy/impl/PhoneWindowManager.java
badd +91 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/src/com/jamdeo/service/dlna/renderer/AudioRenderingControlService.java
badd +19 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/src/com/jamdeo/tv/service/SystemIntentReceiver.java
badd +172 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/ui/internal/VolumeManager.java
badd +328 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/AudioManager.java
badd +210 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/ui/internal/KeyCodeIntentHandler.java
badd +767 ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/media/java/android/media/AudioManager.java
badd +407 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/internal/BaseManager.java
badd +57 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/src/com/jamdeo/tv/service/handlers/AudioRemoteServiceHandler.java
silent! argdel *
edit ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/media/java/android/media/AudioManager.java
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
exe '1resize ' . ((&lines * 9 + 22) / 44)
exe 'vert 1resize ' . ((&columns * 29 + 76) / 153)
exe '2resize ' . ((&lines * 32 + 22) / 44)
exe 'vert 2resize ' . ((&columns * 29 + 76) / 153)
exe 'vert 3resize ' . ((&columns * 123 + 76) / 153)
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
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 767 - ((20 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
767
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 9 + 22) / 44)
exe 'vert 1resize ' . ((&columns * 29 + 76) / 153)
exe '2resize ' . ((&lines * 32 + 22) / 44)
exe 'vert 2resize ' . ((&columns * 29 + 76) / 153)
exe 'vert 3resize ' . ((&columns * 123 + 76) / 153)
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
1resize 9|vert 1resize 29|2resize 32|vert 2resize 29|3resize 42|vert 3resize 123|
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
