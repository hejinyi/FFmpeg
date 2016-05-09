#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2014-04-11  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

declare -i lines=$(wc -l /tmp/allmakefile | awk '{print $1}')

declare -i count=1

while [ $count -lt $lines ]
do
    content=$(sed -n "${count}p" /tmp/allmakefile)
    echo "now grep $content"
    grep Music $content
    count=$(($count + 1))
done
