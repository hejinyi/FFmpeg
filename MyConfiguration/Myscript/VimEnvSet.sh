#!/bin/bash
#
#Program:
#	This program is used to set the width for all windows width of all plugini of vim. 
#
#History:
#	2013/10/31 	gary 	First release


export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$JAVA_HOME/bin"

VIMRCFILE="/home/gary/.vimrc"
if [ ! -f ${VIMRCFILE} ]; then
    echo "${VIMRCFILE} not exit"
fi
STRING1="let g:netrw_winsize="
STRING2="let g:bufExplorerSplitVertSize="
STRING3="let Tlist_WinWidth="
STRING4="let g:winManagerWidth="
declare -i TERMINALWIDTH
declare -i SUBWINDOWWIDTH
TERMINALWIDTH=$(tput cols)
SUBWINDOWWIDTH=$(($TERMINALWIDTH / 5))

declare -i LINE
printf "\n"
echo "********** ${VIMRCFILE} has been modified to ${SUBWINDOWWIDTH} columns **********"
printf "\n"

for var in "$STRING1" "$STRING2" "$STRING3" "$STRING4"
do
    LINE=$(cat -n ${VIMRCFILE} | grep "$var" | wc -l)
    if [ $LINE -gt 1 ]; then
        echo "more than one line match {$var}"      > /dev/null
        exit 1
    fi
    LINE=$(cat -n ${VIMRCFILE} | grep "$var" | awk '{print $1}')
    printf "%d old\t" $LINE     > /dev/null
    sed -n "${LINE}p" ${VIMRCFILE}      > /dev/null
    printf "%d new\t" $LINE     > /dev/null
    sed -i "${LINE}s/=[0-9]*/=${SUBWINDOWWIDTH}/g" ${VIMRCFILE}     > /dev/null
    sed -n "${LINE}p" ${VIMRCFILE}      > /dev/null
    printf "\n"     > /dev/null
done
