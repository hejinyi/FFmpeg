#!/bin/bash
#
# Program:
#   This script is used to reset FFmpeg_github_private
#
# History:
#   2016-05-14  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

cd ~/FFmpeg_github_private

git reset --hard

git clean -df

git branch hejinyi_tmp

git checkout hejinyi_tmp

git branch -D master

git branch master

git checkout master

git branch -D hejinyi_tmp

git pull origin master:master
