#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2013-12-24  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"
ps

declare -i n=$(ps | wc -l)
while [ $n -lt 7 ]
do 
    $0 &
    n=$(ps | wc -l)
done
