#!/bin/bash
#
# Program:
#   This script is used to set the resolution of HDMI-0 to 1600x900 
#
# History:
#   2014-06-17  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync

xrandr --addmode HDMI-0 1600x900_60.00

xrandr --output HDMI-0 --mode 1600x900_60.00
