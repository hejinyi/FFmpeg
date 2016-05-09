#!/bin/bash
#
#Program:
#	This program is used to count the lines of a file, the characts of the longest line of the file, the characts of the shortest line of the file.
#
#History:
#	2013/10/26 	gary 	First release


export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$JAVA_HOME/bin"
declare -i STARTTIME
declare -i ENDTIME
declare -i LARGEST
declare -i LARGESTLINE
declare -i SMALLEST 
declare -i SMALLESTLINE
declare -i LINES
declare -i TERMLINES
declare -i TERMCOLS
declare -i PROBARCOLS
declare -i PROBARSCALE

STARTTIME=$(date +%s)


# Get the lines and columns of the current terminal
TERMLINES=$(tput lines)
TERMCOLS=$(tput cols)
PROBARCOLS=$TERMCOLS
PROBARSCALE=1
while [ $TERMCOLS -lt $((100 / $PROBARSCALE)) ]
do
	PROBARSCALE=$PROBARSCALE+1
	PROBARCOLS=$((100 / $PROBARSCALE))
done
if [ $PROBARCOLS -gt 100 ]; then
		PROBARCOLS=100
fi

###############################################################
# Function Name: updateProBar
# Parameters: $1 Percentage that have finished of the task
#             $2 The total columns of the progressbar
#             $3 The scale of the sum of the column of the prog
#                ressbar to 100
#             $4 Total columns of the file
# Usage: updateProBar 68 50 2 10000
#        updateProBar 68 100 1 10000
#        updateProBar 68 25 4 10000
# Author: Gary
# Time: 2013-10-26
###############################################################
function updateProBar() {
	local FINISHCOLS=$(($1 / $3))
	local LEFTPAD_1=$((($4 - 13) / 2 - 1))
	local LEFTPAD_2=$((($4 - $2) / 2 - 1))
	declare -i FINISHCOLS
	declare -i LEFTPAD_1
	declare -i LEFTPAD_2
	tput civis			# hiden the cursor
	printf "\n"			# Go to the next line
	tput cuu1	# Up one line, then the cursor at the 0 column
	tput setf 2			# Set the color of foreground to green
	tput cuf $LEFTPAD_1
	printf 'Finished:%3d%%\n' $1	# length = 13
	tput cuf $LEFTPAD_2
	printf "["
	local VAR=1
	declare -i VAR
	while [ $VAR -le $2 ]
	do
		if [ $VAR -le $FINISHCOLS ]; then
			printf ">"
		else
			tput setf 7
			printf "=" 
		fi
		VAR=$VAR+1
	done
	printf "]\n"
	if [ $1 -eq 100 ]; then
		tput cnorm
		tput setf 7
		tput bel
	else
		tput cuu 2
	fi
}

if [ "$#" -lt 1 ]; then
    echo "There is no file inputed."
    echo "  Usage:"
    echo "      $0 <filename>"
    exit 1
elif [ "$#" -gt 1 ]; then
    echo "To much files."
    echo "  Usage:"
    echo "      $0 <filename>"
    exit 1
elif [ ! -f "$1" ]; then
    echo "$1 not exit."
    exit 1
fi

LINES=$(wc -l $1 | awk '{print $1}')
if [ "$LINES" -lt 1 ]; then
    echo "$1 is an empty file."
    exit 1
fi

declare -i NUM
declare -i COUNT
declare -i LINEMOD
declare -i PROGRESSBAROLD
declare -i PROGRESSBARNEW
COUNT=$(head -n 1 $1 | wc -m | awk '{print $1}')
NUM=2
LARGEST=$COUNT
SMALLEST=$COUNT
LARGESTLINE=1
SMALLESTLINE=1
PROGRESSBAROLD=1
PROGRESSBARNEW=0

printf "\n"
tput cuf $(((TERMCOLS - 11) / 2 - 1))
tput setf 2
echo "Counting..."
tput setf 7

while [ $NUM -le $LINES ]
do
    COUNT=$(sed -n "${NUM}p" $1 | wc -m | awk '{print $1}')
    if [ "$COUNT" -gt "$LARGEST" ]; then
        LARGEST=${COUNT}
        LARGESTLINE=$NUM
	elif [ "$COUNT" -lt "$SMALLEST" ]; then
        SMALLEST=${COUNT}
        SMALLESTLINE=$NUM
    fi
	NUM=$NUM+1
	PROGRESSBARNEW=$(($NUM * 100 / $LINES))
	if [ $PROGRESSBARNEW -ne $PROGRESSBAROLD ]; then
			updateProBar $PROGRESSBARNEW $PROBARCOLS $PROBARSCALE $TERMCOLS
	fi
	PROGRESSBAROLD=$PROGRESSBARNEW
done
unset COUNT
unset NUM

echo "Filename: $1"
echo "TotalLines: $LINES"
echo -e "LongestLine: ${LARGESTLINE} \t\t character: ${LARGEST}"
echo -e "ShortestLine: ${SMALLESTLINE} \t\t character: ${SMALLEST}"
ENDTIME=$(date +%s)
echo "TotalTime: $((($ENDTIME - $STARTTIME) / 3600))h $((($ENDTIME - $STARTTIME) % 3600 / 60))m $((($ENDTIME - $STARTTIME) % 60))s"
exit 0
