#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2013-11-25  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

repo sync -c -j8
while [ $? -ne 0 ]
do
    sleep 3
    tput setf 4
    echo -en "\n\n########## repo sync -c -j8 failed, sync again ##########\n"
    tput setf 7
    repo sync -c -j8
done
tput setf 2
echo "########## repo sync -c -j8 successed. ##########"
tput setf 7
