" ~/.vim/sessions/vod_silochange.vim:
" Vim session script.
" Created by session.vim 2.4.9 on 30 November 2013 at 16:56:33.
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
cd ~/Amlogic
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +148 vendor/jamdeo/tv/apps/VOD/src/com/jamdeo/tv/vod/player/VodPlayerActivity.java
badd +409 vendor/jamdeo/tv/frameworks/TvServicesFramework/java/com/jamdeo/data/VodDataContract.java
badd +106 vendor/jamdeo/tv/frameworks/TvServicesFramework/java/com/jamdeo/tv/util/ViewUtils.java
badd +249 ~/.vimrc
badd +19 ~/Amlogic/vendor/jamdeo/tv/frameworks/TvServicesFramework/java/com/jamdeo/media/ExtMediaPlayer.java
badd +1224 ~/Amlogic/frameworks/base/media/java/android/media/MediaPlayer.java
silent! argdel *
edit vendor/jamdeo/tv/apps/VOD/src/com/jamdeo/tv/vod/player/VodPlayerActivity.java
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
exe '1resize ' . ((&lines * 6 + 24) / 48)
exe 'vert 1resize ' . ((&columns * 34 + 86) / 172)
exe '2resize ' . ((&lines * 39 + 24) / 48)
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
105
silent! normal zo
264
silent! normal zo
267
silent! normal zo
264
silent! normal zo
277
silent! normal zo
280
silent! normal zo
281
silent! normal zo
282
silent! normal zo
281
silent! normal zo
280
silent! normal zo
277
silent! normal zo
290
silent! normal zo
292
silent! normal zo
293
silent! normal zo
299
silent! normal zo
307
silent! normal zo
313
silent! normal zo
323
silent! normal zo
325
silent! normal zo
323
silent! normal zo
293
silent! normal zo
292
silent! normal zo
290
silent! normal zo
349
silent! normal zo
352
silent! normal zo
358
silent! normal zo
349
silent! normal zo
362
silent! normal zo
365
silent! normal zo
367
silent! normal zo
365
silent! normal zo
373
silent! normal zo
362
silent! normal zo
379
silent! normal zo
385
silent! normal zo
393
silent! normal zo
400
silent! normal zo
409
silent! normal zo
400
silent! normal zo
426
silent! normal zo
379
silent! normal zo
441
silent! normal zo
449
silent! normal zo
453
silent! normal zo
454
silent! normal zo
453
silent! normal zo
459
silent! normal zo
460
silent! normal zo
459
silent! normal zo
449
silent! normal zo
468
silent! normal zo
472
silent! normal zo
468
silent! normal zo
477
silent! normal zo
485
silent! normal zo
477
silent! normal zo
492
silent! normal zo
611
silent! normal zo
615
silent! normal zo
625
silent! normal zo
633
silent! normal zo
625
silent! normal zo
647
silent! normal zo
652
silent! normal zo
662
silent! normal zo
664
silent! normal zo
671
silent! normal zo
662
silent! normal zo
677
silent! normal zo
678
silent! normal zo
688
silent! normal zo
689
silent! normal zo
693
silent! normal zo
695
silent! normal zo
693
silent! normal zo
689
silent! normal zo
688
silent! normal zo
708
silent! normal zo
713
silent! normal zo
678
silent! normal zo
708
silent! normal zo
713
silent! normal zo
804
silent! normal zo
806
silent! normal zo
811
silent! normal zo
804
silent! normal zo
816
silent! normal zo
817
silent! normal zo
820
silent! normal zo
822
silent! normal zo
824
silent! normal zo
827
silent! normal zo
829
silent! normal zo
827
silent! normal zo
822
silent! normal zo
880
silent! normal zo
820
silent! normal zo
884
silent! normal zo
816
silent! normal zo
890
silent! normal zo
891
silent! normal zo
890
silent! normal zo
897
silent! normal zo
898
silent! normal zo
897
silent! normal zo
908
silent! normal zo
909
silent! normal zo
908
silent! normal zo
925
silent! normal zo
926
silent! normal zo
932
silent! normal zo
926
silent! normal zo
925
silent! normal zo
945
silent! normal zo
946
silent! normal zo
950
silent! normal zo
952
silent! normal zo
955
silent! normal zo
960
silent! normal zo
974
silent! normal zo
952
silent! normal zo
950
silent! normal zo
945
silent! normal zo
982
silent! normal zo
983
silent! normal zo
986
silent! normal zo
987
silent! normal zo
990
silent! normal zo
987
silent! normal zo
986
silent! normal zo
982
silent! normal zo
1000
silent! normal zo
1003
silent! normal zo
1007
silent! normal zo
1011
silent! normal zo
1021
silent! normal zo
1000
silent! normal zo
1034
silent! normal zo
1035
silent! normal zo
1041
silent! normal zo
1061
silent! normal zo
1034
silent! normal zo
1072
silent! normal zo
1073
silent! normal zo
1078
silent! normal zo
1072
silent! normal zo
1084
silent! normal zo
1085
silent! normal zo
1089
silent! normal zo
1084
silent! normal zo
1103
silent! normal zo
1104
silent! normal zo
1111
silent! normal zo
1112
silent! normal zo
1111
silent! normal zo
1119
silent! normal zo
1120
silent! normal zo
1122
silent! normal zo
1120
silent! normal zo
1119
silent! normal zo
1104
silent! normal zo
1103
silent! normal zo
1135
silent! normal zo
1136
silent! normal zo
1137
silent! normal zo
1136
silent! normal zo
1135
silent! normal zo
1148
silent! normal zo
1151
silent! normal zo
1153
silent! normal zo
1156
silent! normal zo
1157
silent! normal zo
1159
silent! normal zo
1163
silent! normal zo
1164
silent! normal zo
1163
silent! normal zo
1157
silent! normal zo
1183
silent! normal zo
1156
silent! normal zo
1151
silent! normal zo
1148
silent! normal zo
1200
silent! normal zo
1204
silent! normal zo
1210
silent! normal zo
1200
silent! normal zo
1224
silent! normal zo
1228
silent! normal zo
1234
silent! normal zo
1237
silent! normal zo
1251
silent! normal zo
1257
silent! normal zo
1269
silent! normal zo
1251
silent! normal zo
1234
silent! normal zo
1224
silent! normal zo
1291
silent! normal zo
1294
silent! normal zo
1303
silent! normal zo
1306
silent! normal zo
1294
silent! normal zo
1291
silent! normal zo
1322
silent! normal zo
1326
silent! normal zo
1331
silent! normal zo
1333
silent! normal zo
1344
silent! normal zo
1347
silent! normal zo
1331
silent! normal zo
1322
silent! normal zo
1362
silent! normal zo
1366
silent! normal zo
1371
silent! normal zo
1374
silent! normal zo
1379
silent! normal zo
1374
silent! normal zo
1383
silent! normal zo
1389
silent! normal zo
1390
silent! normal zo
1391
silent! normal zo
1397
silent! normal zo
1400
silent! normal zo
1405
silent! normal zo
1391
silent! normal zo
1412
silent! normal zo
1390
silent! normal zo
1389
silent! normal zo
1417
silent! normal zo
1422
silent! normal zo
1431
silent! normal zo
1371
silent! normal zo
1362
silent! normal zo
1443
silent! normal zo
1450
silent! normal zo
1460
silent! normal zo
1471
silent! normal zo
1477
silent! normal zo
1478
silent! normal zo
1479
silent! normal zo
1480
silent! normal zo
1479
silent! normal zo
1478
silent! normal zo
1477
silent! normal zo
1460
silent! normal zo
1443
silent! normal zo
1496
silent! normal zo
1554
silent! normal zo
1496
silent! normal zo
1580
silent! normal zo
1581
silent! normal zo
1583
silent! normal zo
1586
silent! normal zo
1583
silent! normal zo
1603
silent! normal zo
1608
silent! normal zo
1603
silent! normal zo
1624
silent! normal zo
1629
silent! normal zo
1624
silent! normal zo
1581
silent! normal zo
1580
silent! normal zo
1644
silent! normal zo
1645
silent! normal zo
1648
silent! normal zo
1652
silent! normal zo
1655
silent! normal zo
1652
silent! normal zo
1644
silent! normal zo
1671
silent! normal zo
1672
silent! normal zo
1674
silent! normal zo
1676
silent! normal zo
1674
silent! normal zo
1683
silent! normal zo
1672
silent! normal zo
1671
silent! normal zo
1697
silent! normal zo
1698
silent! normal zo
1703
silent! normal zo
1706
silent! normal zo
1721
silent! normal zo
1703
silent! normal zo
1697
silent! normal zo
1731
silent! normal zo
1732
silent! normal zo
1736
silent! normal zo
1740
silent! normal zo
1745
silent! normal zo
1748
silent! normal zo
1756
silent! normal zo
1759
silent! normal zo
1762
silent! normal zo
1763
silent! normal zo
1762
silent! normal zo
1771
silent! normal zo
1748
silent! normal zo
1731
silent! normal zo
1786
silent! normal zo
1787
silent! normal zo
1788
silent! normal zo
1787
silent! normal zo
1795
silent! normal zo
1786
silent! normal zo
1847
silent! normal zo
1849
silent! normal zo
1847
silent! normal zo
1855
silent! normal zo
1856
silent! normal zo
1855
silent! normal zo
1874
silent! normal zo
1876
silent! normal zo
1874
silent! normal zo
1889
silent! normal zo
1890
silent! normal zo
1891
silent! normal zo
1894
silent! normal zo
1891
silent! normal zo
1890
silent! normal zo
1889
silent! normal zo
1905
silent! normal zo
1908
silent! normal zo
1911
silent! normal zo
1905
silent! normal zo
1916
silent! normal zo
1918
silent! normal zo
1925
silent! normal zo
1927
silent! normal zo
1925
silent! normal zo
1916
silent! normal zo
1935
silent! normal zo
1936
silent! normal zo
1942
silent! normal zo
1944
silent! normal zo
1942
silent! normal zo
1948
silent! normal zo
1935
silent! normal zo
1957
silent! normal zo
1964
silent! normal zo
1965
silent! normal zo
1975
silent! normal zo
1979
silent! normal zo
1983
silent! normal zo
1987
silent! normal zo
1989
silent! normal zo
2001
silent! normal zo
1987
silent! normal zo
1983
silent! normal zo
1964
silent! normal zo
2014
silent! normal zo
2015
silent! normal zo
2016
silent! normal zo
2015
silent! normal zo
2021
silent! normal zo
2022
silent! normal zo
2026
silent! normal zo
2021
silent! normal zo
2014
silent! normal zo
2034
silent! normal zo
2037
silent! normal zo
2043
silent! normal zo
2044
silent! normal zo
2047
silent! normal zo
2052
silent! normal zo
2043
silent! normal zo
2034
silent! normal zo
2062
silent! normal zo
2067
silent! normal zo
2083
silent! normal zo
2084
silent! normal zo
2083
silent! normal zo
2098
silent! normal zo
2102
silent! normal zo
2107
silent! normal zo
2112
silent! normal zo
2113
silent! normal zo
2116
silent! normal zo
2119
silent! normal zo
2112
silent! normal zo
2098
silent! normal zo
2125
silent! normal zo
2127
silent! normal zo
2132
silent! normal zo
2133
silent! normal zo
2132
silent! normal zo
2125
silent! normal zo
677
silent! normal zo
722
silent! normal zo
730
silent! normal zo
722
silent! normal zo
738
silent! normal zo
739
silent! normal zo
744
silent! normal zo
738
silent! normal zo
751
silent! normal zo
757
silent! normal zo
760
silent! normal zo
757
silent! normal zo
751
silent! normal zo
771
silent! normal zo
772
silent! normal zo
775
silent! normal zo
779
silent! normal zo
771
silent! normal zo
786
silent! normal zo
787
silent! normal zo
790
silent! normal zo
794
silent! normal zo
786
silent! normal zo
804
silent! normal zo
806
silent! normal zo
811
silent! normal zo
804
silent! normal zo
816
silent! normal zo
817
silent! normal zo
820
silent! normal zo
822
silent! normal zo
824
silent! normal zo
827
silent! normal zo
829
silent! normal zo
827
silent! normal zo
822
silent! normal zo
880
silent! normal zo
820
silent! normal zo
884
silent! normal zo
816
silent! normal zo
890
silent! normal zo
891
silent! normal zo
890
silent! normal zo
897
silent! normal zo
898
silent! normal zo
897
silent! normal zo
908
silent! normal zo
909
silent! normal zo
908
silent! normal zo
925
silent! normal zo
926
silent! normal zo
932
silent! normal zo
926
silent! normal zo
925
silent! normal zo
945
silent! normal zo
946
silent! normal zo
950
silent! normal zo
952
silent! normal zo
955
silent! normal zo
960
silent! normal zo
974
silent! normal zo
952
silent! normal zo
950
silent! normal zo
945
silent! normal zo
982
silent! normal zo
983
silent! normal zo
986
silent! normal zo
987
silent! normal zo
990
silent! normal zo
987
silent! normal zo
986
silent! normal zo
982
silent! normal zo
1000
silent! normal zo
1003
silent! normal zo
1007
silent! normal zo
1011
silent! normal zo
1021
silent! normal zo
1000
silent! normal zo
1034
silent! normal zo
1035
silent! normal zo
1041
silent! normal zo
1061
silent! normal zo
1034
silent! normal zo
1072
silent! normal zo
1073
silent! normal zo
1078
silent! normal zo
1072
silent! normal zo
1084
silent! normal zo
1085
silent! normal zo
1089
silent! normal zo
1084
silent! normal zo
1103
silent! normal zo
1104
silent! normal zo
1111
silent! normal zo
1112
silent! normal zo
1111
silent! normal zo
1119
silent! normal zo
1120
silent! normal zo
1122
silent! normal zo
1120
silent! normal zo
1119
silent! normal zo
1104
silent! normal zo
1103
silent! normal zo
1135
silent! normal zo
1136
silent! normal zo
1137
silent! normal zo
1136
silent! normal zo
1135
silent! normal zo
1148
silent! normal zo
1151
silent! normal zo
1153
silent! normal zo
1156
silent! normal zo
1157
silent! normal zo
1159
silent! normal zo
1163
silent! normal zo
1164
silent! normal zo
1163
silent! normal zo
1157
silent! normal zo
1183
silent! normal zo
1156
silent! normal zo
1151
silent! normal zo
1148
silent! normal zo
1200
silent! normal zo
1204
silent! normal zo
1210
silent! normal zo
1200
silent! normal zo
1224
silent! normal zo
1228
silent! normal zo
1234
silent! normal zo
1237
silent! normal zo
1251
silent! normal zo
1257
silent! normal zo
1269
silent! normal zo
1251
silent! normal zo
1234
silent! normal zo
1224
silent! normal zo
1291
silent! normal zo
1294
silent! normal zo
1303
silent! normal zo
1306
silent! normal zo
1294
silent! normal zo
1291
silent! normal zo
1322
silent! normal zo
1326
silent! normal zo
1331
silent! normal zo
1333
silent! normal zo
1344
silent! normal zo
1347
silent! normal zo
1331
silent! normal zo
1322
silent! normal zo
1362
silent! normal zo
1366
silent! normal zo
1371
silent! normal zo
1374
silent! normal zo
1379
silent! normal zo
1374
silent! normal zo
1383
silent! normal zo
1389
silent! normal zo
1390
silent! normal zo
1391
silent! normal zo
1397
silent! normal zo
1400
silent! normal zo
1405
silent! normal zo
1391
silent! normal zo
1412
silent! normal zo
1390
silent! normal zo
1389
silent! normal zo
1417
silent! normal zo
1422
silent! normal zo
1431
silent! normal zo
1371
silent! normal zo
1362
silent! normal zo
1443
silent! normal zo
1450
silent! normal zo
1460
silent! normal zo
1471
silent! normal zo
1477
silent! normal zo
1478
silent! normal zo
1479
silent! normal zo
1480
silent! normal zo
1479
silent! normal zo
1478
silent! normal zo
1477
silent! normal zo
1460
silent! normal zo
1443
silent! normal zo
1496
silent! normal zo
1554
silent! normal zo
1496
silent! normal zo
1580
silent! normal zo
1581
silent! normal zo
1583
silent! normal zo
1586
silent! normal zo
1583
silent! normal zo
1603
silent! normal zo
1608
silent! normal zo
1603
silent! normal zo
1624
silent! normal zo
1629
silent! normal zo
1624
silent! normal zo
1581
silent! normal zo
1580
silent! normal zo
1644
silent! normal zo
1645
silent! normal zo
1648
silent! normal zo
1652
silent! normal zo
1655
silent! normal zo
1652
silent! normal zo
1644
silent! normal zo
1671
silent! normal zo
1672
silent! normal zo
1674
silent! normal zo
1676
silent! normal zo
1674
silent! normal zo
1683
silent! normal zo
1672
silent! normal zo
1671
silent! normal zo
1697
silent! normal zo
1698
silent! normal zo
1703
silent! normal zo
1706
silent! normal zo
1721
silent! normal zo
1703
silent! normal zo
1697
silent! normal zo
1731
silent! normal zo
1732
silent! normal zo
1736
silent! normal zo
1740
silent! normal zo
1745
silent! normal zo
1748
silent! normal zo
1756
silent! normal zo
1759
silent! normal zo
1762
silent! normal zo
1763
silent! normal zo
1762
silent! normal zo
1771
silent! normal zo
1748
silent! normal zo
1731
silent! normal zo
1786
silent! normal zo
1787
silent! normal zo
1788
silent! normal zo
1787
silent! normal zo
1795
silent! normal zo
1786
silent! normal zo
1847
silent! normal zo
1849
silent! normal zo
1847
silent! normal zo
1855
silent! normal zo
1856
silent! normal zo
1855
silent! normal zo
1874
silent! normal zo
1876
silent! normal zo
1874
silent! normal zo
1889
silent! normal zo
1890
silent! normal zo
1891
silent! normal zo
1894
silent! normal zo
1891
silent! normal zo
1890
silent! normal zo
1889
silent! normal zo
1905
silent! normal zo
1908
silent! normal zo
1911
silent! normal zo
1905
silent! normal zo
1916
silent! normal zo
1918
silent! normal zo
1925
silent! normal zo
1927
silent! normal zo
1925
silent! normal zo
1916
silent! normal zo
1935
silent! normal zo
1936
silent! normal zo
1942
silent! normal zo
1944
silent! normal zo
1942
silent! normal zo
1948
silent! normal zo
1935
silent! normal zo
1957
silent! normal zo
1964
silent! normal zo
1965
silent! normal zo
1975
silent! normal zo
1979
silent! normal zo
1983
silent! normal zo
1987
silent! normal zo
1989
silent! normal zo
2001
silent! normal zo
1987
silent! normal zo
1983
silent! normal zo
1964
silent! normal zo
2014
silent! normal zo
2015
silent! normal zo
2016
silent! normal zo
2015
silent! normal zo
2021
silent! normal zo
2022
silent! normal zo
2026
silent! normal zo
2021
silent! normal zo
2014
silent! normal zo
2034
silent! normal zo
2037
silent! normal zo
2043
silent! normal zo
2044
silent! normal zo
2047
silent! normal zo
2052
silent! normal zo
2043
silent! normal zo
2034
silent! normal zo
2062
silent! normal zo
2067
silent! normal zo
2083
silent! normal zo
2084
silent! normal zo
2083
silent! normal zo
2098
silent! normal zo
2102
silent! normal zo
2107
silent! normal zo
2112
silent! normal zo
2113
silent! normal zo
2116
silent! normal zo
2119
silent! normal zo
2112
silent! normal zo
2098
silent! normal zo
2125
silent! normal zo
2127
silent! normal zo
2132
silent! normal zo
2133
silent! normal zo
2132
silent! normal zo
2125
silent! normal zo
105
silent! normal zo
let s:l = 838 - ((22 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
838
normal! 040l
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 6 + 24) / 48)
exe 'vert 1resize ' . ((&columns * 34 + 86) / 172)
exe '2resize ' . ((&lines * 39 + 24) / 48)
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
1resize 6|vert 1resize 34|2resize 39|vert 2resize 34|3resize 46|vert 3resize 137|
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
