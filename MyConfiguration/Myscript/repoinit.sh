#!/bin/bash
#
# Program:
#   This script is used to init the repo respotary 
#
# History:
#   2014-04-22  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

if [ $# -ne 1 ]; then
    tput setf 4
    echo "########## You must offer the branch of android ##########"
    tput setf 7
    exit 1
fi

repo init -u https://android.googlesource.com/platform/manifest -b $1
while [ $? -ne 0 ]
do
    sleep 3
    tput setf 4
    echo -en "\n\n########## repo init -u https://android.googlesource.com/platform/manifest -b $1 (failed), init again ##########\n"
    tput setf 7
    repo init -u https://android.googlesource.com/platform/manifest -b $1
done
tput setf 2
echo "########## repo init -u https://android.googlesource.com/platform/manifest -b $1 (successed) ##########"
tput setf 7
