#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2013-11-25  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:$HOME/java/adt-bundle-linux-x86_64-20130729/sdk/platform-tools"

if [ $# -ne 1 ]; then
    echo "please input a process name"
    exit 1
fi
declare -i num=0;
num=$(adb devices | grep device$ | wc -l)
echo "there is $num devices connected"
if [ $num -lt 1 ]; then
    echo "please connect the device use adb"
    exit 1
elif [ $num -gt 1 ]; then
    echo "more than 1 device is connected"
    exit 1
fi
adb shell logcat -c; adb shell logcat -v threadtime | grep "  $(adb shell ps | grep $1 | awk '{print $2}') "
