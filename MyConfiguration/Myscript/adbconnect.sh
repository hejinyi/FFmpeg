#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2014-06-04  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:/home/gary/java/Android_SDK/platform-tools"

if [ $# -ne 1 ]; then
    echo "please offer the last num of the ip"
    exit 1
fi
adb disconnect
adb connect 192.168.1.$1
adb root
adb connect 192.168.1.$1
adb remount
