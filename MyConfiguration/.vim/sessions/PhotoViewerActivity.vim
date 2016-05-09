" ~/.vim/sessions/PhotoViewerActivity.vim:
" Vim session script.
" Created by session.vim 2.4.9 on 28 February 2014 at 18:09:18.
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
badd +206 vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/SourceManager.java
badd +188 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/src/com/jamdeo/tv/service/handlers/SourceRemoteServiceHandler.java
badd +1221 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/gen/com/jamdeo/tv/common/EnumConstants.java
badd +1317 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/internal/FactoryManager.java
badd +513 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/internal/BaseManager.java
badd +304 ~/k370_work/vm_linux/android/ics-4.x/out/target/common/obj/JAVA_LIBRARIES/com.jamdeo.tvservicesframework_intermediates/src/java/com/jamdeo/tv/service/IConfigurationRemoteService.java
badd +1371 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/src/com/jamdeo/tv/service/handlers/ConfigurationRemoteServiceHandler.java
badd +17 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/picture/PictureConfig.java
badd +100 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/AbstractConfigGroup.java
badd +744 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/packages/apps/Settings/src/com/jamdeo/tvsettings/SettingsScreenActivity.java
badd +1 ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/core/java/android/view/KeyEvent.java
badd +307 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/packages/apps/Settings/src/com/jamdeo/tvsettings/MenuBoxSoundFragment.java
badd +43 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/IConfigOption.java
badd +18 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/IntegerConfigOption.java
badd +176 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/AbstractConfigOption.java
badd +795 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/ui/internal/FactoryModeManager.java
badd +105 ~/k370_work/vm_linux/android/ics-4.x/hardware/libhardware/include/hardware/til/til_source.h
badd +412 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/packages/apps/MediaCenter/src/com/jamdeo/tv/mediacenter/PhotoViewerActivity.java
badd +178 ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/core/java/android/content/ContentProvider.java
badd +112 ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/core/java/android/content/ContentProviderNative.java
badd +401 ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/core/java/android/database/sqlite/SQLiteProgram.java
badd +923 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/src/com/jamdeo/service/media/MediaData.java
silent! argdel *
edit ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/packages/apps/MediaCenter/src/com/jamdeo/tv/mediacenter/PhotoViewerActivity.java
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
exe '1resize ' . ((&lines * 22 + 22) / 44)
exe 'vert 1resize ' . ((&columns * 30 + 76) / 153)
exe '2resize ' . ((&lines * 19 + 22) / 44)
exe 'vert 2resize ' . ((&columns * 30 + 76) / 153)
exe 'vert 3resize ' . ((&columns * 122 + 76) / 153)
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
let s:l = 390 - ((14 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
390
normal! 035l
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 22 + 22) / 44)
exe 'vert 1resize ' . ((&columns * 30 + 76) / 153)
exe '2resize ' . ((&lines * 19 + 22) / 44)
exe 'vert 2resize ' . ((&columns * 30 + 76) / 153)
exe 'vert 3resize ' . ((&columns * 122 + 76) / 153)
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
1resize 22|vert 1resize 30|2resize 19|vert 2resize 30|3resize 42|vert 3resize 122|
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
