#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2013-11-25  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

if [ $# -ne 1 ]; then
    tput setf 4
    echo "There is must only one parameter, namely the branch name"
    tput setf 7
    exit 1
fi

repo init -u ssh://10.128.0.30/tv/manifest -b $1
while [ $? -ne 0 ]
do
    sleep 3
    tput setf 4
    echo -en "\n\n########## repo init -u ssh://10.128.0.30/tv/manifest -b $1 (failed), reinit ##########\n"
    tput setf 7
    repo init -u ssh://10.128.0.30/tv/manifest -b $1
done
tput setf 2
echo "##########  repo init -u ssh://10.128.0.30/tv/manifest -b $1 (successed). ##########"
tput setf 7

repo sync -c -j4
while [ $? -ne 0 ]
do
    sleep 3
    tput setf 4
    echo -en "\n\n########## repo sync -c -j4 failed, resync ##########\n"
    tput setf 7
    repo sync -c -j4
done
tput setf 2
echo "########## repo sync -c -j4 successed ##########"
tput setf 7

repo start master --all
