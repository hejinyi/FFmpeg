#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2013-12-24  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"



if [ -z $n ]; then
    declare -i n=5
    export n
    ps aux | grep "$0" | grep 'bash' | grep -v 'grep'
    declare mainpid=$(ps aux | grep "$0" | grep 'bash' | grep -v 'grep' | awk '{print $2}')
    mainpid=$(echo $mainpid)
    while [ $n -gt 0 ]
    do
        $0 &
        sleep 2
        n=$(($n - 1))
    done
    declare leftpid
    leftpid=$(ps aux | grep "$0" | grep 'bash' | grep -v 'grep' | awk '{print $2}')
    leftpid=$(echo $leftpid)
    while [ "$mainpid" != "$leftpid" ]
    do
        sleep 1
        echo "mainpid = $mainpid, leftpid = $leftpid"
        leftpid=$(ps aux | grep "$0" | grep 'bash' | grep -v 'grep' | awk '{print $2}')
        leftpid=$(echo $leftpid)
        echo -e "------------------------------------------------\n"
    done
fi
echo "my pid is $$"
sleep 20
