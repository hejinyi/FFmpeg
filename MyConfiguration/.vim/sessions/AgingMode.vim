" ~/.vim/sessions/AgingMode.vim:
" Vim session script.
" Created by session.vim 2.4.9 on 11 March 2014 at 21:40:24.
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
badd +888 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/ui/internal/FactoryModeManager.java
badd +396 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/PictureManager.java
badd +544 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/gen/com/jamdeo/tv/common/EnumConstants.java
badd +370 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/internal/BaseManager.java
badd +1117 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/src/com/jamdeo/tv/service/handlers/ConfigurationRemoteServiceHandler.java
badd +1 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/IConfigOption.java
badd +15 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/picture/PictureConfig.java
badd +13 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/picture/IPictureConfig.java
badd +130 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/AbstractConfigGroup.java
badd +214 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/AbstractConfigOption.java
badd +185 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/service/handlers/TvNative.java
badd +376 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/jni/LibTvJni_config.cpp
badd +10 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/IConfigStorageHelper.java
badd +145 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/SharedPrefConfigStorageHelper.java
badd +72 ~/k370_work/vm_linux/android/dtv-android/tv_addon_ics/framework/tv/java/com/mediatek/tv/common/ConfigValue.java
badd +186 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/common/SharedPrefCache.java
badd +5192 ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/res/xml/config_data.xml
badd +3911 ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/policy/src_tv/com/android/internal/policy/impl/PhoneWindowManager.java
badd +809 ~/k370_work/vm_linux/android/ics-4.x/frameworks/base/media/java/android/media/AudioManager.java
badd +112 ~/k370_work/vm_linux/android/ics-4.x/hardware/libhardware/include/hardware/til/til_picture.h
badd +88 ~/k370_work/vm_linux/android/ics-4.x/hardware/libhardware/include/hardware/til/til_config.h
badd +80 ~/k370_work/vm_linux/android/ics-4.x/hardware/mtk/til/til_config.c
badd +552 ~/k370_work/vm_linux/android/ics-4.x/hardware/mtk/til/til_picture.c
badd +270 ~/k370_work/vm_linux/android/ics-4.x/hardware/mtk/til/mtk_if.c
badd +11331 ~/k370_work/vm_linux/dtv_linux/project_x_linux/dtv_svc_client/custom/hisense/config/acfg_custom.c
silent! argdel *
edit ~/k370_work/vm_linux/android/ics-4.x/vendor/jamdeo/frameworks/tv/apps/TVServices/src/com/jamdeo/tv/service/handlers/ConfigurationRemoteServiceHandler.java
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
exe '1resize ' . ((&lines * 25 + 22) / 44)
exe 'vert 1resize ' . ((&columns * 33 + 76) / 153)
exe '2resize ' . ((&lines * 16 + 22) / 44)
exe 'vert 2resize ' . ((&columns * 33 + 76) / 153)
exe 'vert 3resize ' . ((&columns * 119 + 76) / 153)
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
let s:l = 3041 - ((19 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3041
normal! 041l
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 25 + 22) / 44)
exe 'vert 1resize ' . ((&columns * 33 + 76) / 153)
exe '2resize ' . ((&lines * 16 + 22) / 44)
exe 'vert 2resize ' . ((&columns * 33 + 76) / 153)
exe 'vert 3resize ' . ((&columns * 119 + 76) / 153)
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
1resize 25|vert 1resize 33|2resize 16|vert 2resize 33|3resize 42|vert 3resize 119|
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
