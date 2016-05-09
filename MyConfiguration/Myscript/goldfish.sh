#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2014-07-31  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

cd /home/gary/Documents/android4.4
declare DIR="/home/gary/Documents/android4.4/kernel"
if [ -d "./kernel" ]; then
    rm -rf $DIR
fi
mkdir $DIR
cd $DIR

git clone http://android.googlesource.com/kernel/goldfish.git
while [ $? -ne 0 ]
do
    sleep 3
    echo "git clone http://android.googlesource.com/kernel/goldfish.git failed ..."
    echo "try again"
    cd /home/gary/Documents/android4.4
    rm -rf $DIR
    mkdir $DIR
    cd $DIR
    git clone http://android.googlesource.com/kernel/goldfish.git
done
