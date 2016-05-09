#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2014-05-26  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

##############################################################################################
# Function name: getTheMaxInternal
# Parameter: $1 which num do you want to get the max internal that had been happened
# Parameter: $2 which file do you want to get the max internal that had been happened
##############################################################################################
function getTheMinMaxInternal() {
    cat -n $2 | awk "{if (\$2 == $1) {print \$0}}" \
        | awk "BEGIN {maxinterval = 0; mininterval = 0; midinterval = 0; count = 0; lastinterval = 0; weight = 0; prenum = 0}; 
                {
                    if (prenum != 0) {
                        if (\$1 - prenum > maxinterval) {
                            maxinterval = \$1 - prenum;
                        } else if (\$1 - prenum < mininterval) {
                            mininterval = \$1 - prenum;
                        }
                        count++;
                        midinterval = midinterval + \$1 - prenum;
                        prenum = \$1;
                    } else {
                        prenum = \$1;
                        mininterval = prenum;
                        count++;
                        midinterval = prenum;
                    }; 
                }
                END {midinterval = midinterval / count; lastinterval = $theLastLine - prenum; weight = lastinterval / midinterval * 100; print $1\"  \"maxinterval\" \"mininterval\" \"midinterval\" \"lastinterval\"  \"weight}"
}
##############################################################################################
# End of function
##############################################################################################

if [ $# -ne 0 -a $# -ne 7 ]; then
    echo "parameter wrong"
    exit 1
elif [ $# -eq 7 ]; then
    echo " $1 $2 $3 $4 $5 $6 " >> ~/Documents/ShuangSeQiu_hong
    sed -i 's/ 0/  /g' ~/Documents/ShuangSeQiu_hong
    echo " $7 " >> ~/Documents/ShuangSeQiu_lan
    sed -i 's/ 0/  /g' ~/Documents/ShuangSeQiu_lan
fi
declare -i theLastLine=$(cat -n ~/Documents/ShuangSeQiu_lan | tail -n 1 | awk '{print $1}')
declare -i COUNT=1
COUNT=1
rm -f /tmp/lanqiu
while [ $COUNT -le 16 ]
do
    getTheMinMaxInternal $COUNT ~/Documents/ShuangSeQiu_lan >> /tmp/lanqiu
    COUNT=$(($COUNT + 1))
done
sed -i 's/\.[0-9]*//g' /tmp/lanqiu


declare -i MAXINTERVAL=$(awk '{print $NF}' /tmp/lanqiu | sort -nr | head -n 1)
declare -i SUMLAN
SUMLAN=$(grep "$MAXINTERVAL\$" /tmp/lanqiu | sed -n '1p' | awk '{print $1}')

COUNT=1
rm -f /tmp/hongqiu
while [ $COUNT -le 33 ]
do
    cp ~/Documents/ShuangSeQiu_hong /tmp/${COUNT}_hong
    sed -i "/ ${COUNT} /s/^.*$/ ${COUNT} /g" /tmp/${COUNT}_hong
    sed -i "/ ${COUNT} /! s/^.*$/ 0 /g" /tmp/${COUNT}_hong
    getTheMinMaxInternal $COUNT /tmp/${COUNT}_hong >> /tmp/hongqiu
    # rm -f /tmp/${COUNT}_hong
    COUNT=$(($COUNT + 1))
done
sed -i 's/\.[0-9]*//g' /tmp/hongqiu
SUMHONG=$(awk '{print $NF" "NR}' /tmp/hongqiu | sort -nr | head -n 6 | awk '{print $2}' | sort -n)
RESULT="$SUMHONG | $SUMLAN"

declare BEGINDATE="2014/06/15"
declare -i BEGINDAY=7
declare -i DAYS=0
theLastLine=$(($theLastLine + 1))
declare -i ESOPLE=$((theLastLine - 1660))
DAYS=$(($ESOPLE / 3 * 7 + $ESOPLE % 3 * 2))
date +%x -d "$BEGINDATE $DAYS day"

echo "$theLastLine"
echo $RESULT
