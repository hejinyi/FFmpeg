#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2014-12-18  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

if [ ! -z "$(grep 'Cursor.*opened' $1)" ]; then
    TMPOPEN="/tmp/TestCursorOpen.txt"
    TMPCLOSE="/tmp/TestCursorClose.txt"
    rm -f $TMPOPEN
    rm -f $TMPCLOSE
    grep 'Cursor.*opened' $1 > $TMPOPEN
    grep 'Cursor.*closed' $1 > $TMPCLOSE
    cat $TMPCLOSE | awk '{print $8}' | xargs -n 1 -I % sed -i /%/d $TMPOPEN
    echo "lines = `wc -l $TMPOPEN | awk '{print $1}'`"
    echo "------------------------------------"
    echo "                                    "
else
    echo "no information in $1"
    exit 0
fi
