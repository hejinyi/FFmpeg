#!/bin/bash
#
# Program:
#   This script is used to get the bootchart of startup process of android 
#
# History:
#   2014-02-22  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:$HOME/java/Android_SDK/platform-tools"

if [ -z "$1" ]; then
    while [ "${BOOTCOMPLETE}" != "y" -a "${BOOTCOMPLETE}" != "Y" ]
    do
        tput setf 2
        echo "There are 3 step to do:"
        echo "\tstep 1: make sure that there is file 'bootchart-start' in the TV target board."
        echo "\tstep 2: make sure that there is a empty directory 'bootchart'  in the TV target board."
        echo "\tstep 3: reboot TV."
        tput setf 4
        read -p "Have you rebooted the TV?(y/Y):" BOOTCOMPLETE
        tput setf 7
    done

    cd /home/gary/k370_work/vm_linux/android/ics-4.x/system/core/init
    rm -f bootchart.tgz
    echo "Begin to sleep for 140s, please wait..."
    sleep 140
    adb remount 2> /dev/null
    if [ "$?" -ne 0 ]; then
        CONNECTED="n"
    else
        CONNECTED="y"
    fi
    while [ "${CONNECTED}" != "y" -a "${CONNECTED}" != "Y" ]
    do
        echo "Please connect the devices by adb first."
        read -p "Have you connected the devices by adb?(y/Y):" CONNECTED 
    done
    ./grab-bootchart.sh
else
    cp -v $1 .
fi
if [ -d ./bootchart ]; then
    rm -rf bootchart
fi
mkdir bootchart
tar -zxvf bootchart.tgz -C ./bootchart
# sed -i '/(.* .*)/d' ./bootchart/proc_ps.log
sed -i '/(.* .*)/s/)/)\n/g' ./bootchart/proc_ps.log
sed -i '/(.* .*)[[:space:]]*$/s/[[:space:]]/#/g' ./bootchart/proc_ps.log
sed -i '/(.*#.*)/N;s/\n//g' ./bootchart/proc_ps.log
sed -i '/#(/s/#(/ (/g' ./bootchart/proc_ps.log
cd bootchart
tar -zcvf bootchart.tgz *
bootchart ./bootchart.tgz
