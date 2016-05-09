#!/bin/bash
#
# Program:
#   This script is used to format the logfile generated by LogHelpler. 
#
# History:
#   2014-05-17  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

#############################################################################################
# Function handleSinglePidTid
# Parameters: $1 file to be handled
#             $2 PID to be handled
#             $3 TID to be handled
#############################################################################################
declare -i STARTTIME=$(date +%s)
declare TMPFILE="/tmp/.formatLogHelplerFile"
function handleSinglePidTid() {
    local file=$1
    local pid=$2
    local tid=$3

    awk "BEGIN {count = 0; treated = 0; tmpcount = 0; pattern = \"\"; flag = 0; methodname = \"\"}; 
        /$pid  $tid.*Enter<[0-9]+>/ && ! /$pid  $tid.*Enter<[0-9]+>.* if.*{/ && !/$pid  $tid.*Enter<[0-9]+>.* else.*{/ && !/$pid  $tid.*Enter<[0-9]+>.* case.*:/ {
            methodname = \$7\$8
            treated = 1;
            count++; 
            tmpcount = count;
            pattern = \$2\"  \"\$3\" \"\$4\" \"\$5\" \";
            flag = 0;
            while (tmpcount > 1) {
                if (flag == 0) {
                    pattern = pattern \"  \";
                    flag = 1;
                } else {
                    pattern = pattern \"  \";
                    flag = 0;
                }
                tmpcount--;
            }; 
            gsub(/[0-9]+[[:space:]]+[0-9]+[[:space:]]+[A-Z][[:space:]]+[^:]+(:|::) /,pattern);
            if ($CREATEFOLDER == 1) {
                gsub(/^/,\"\\\"          \"methodname\"--------{{{\n\");
            }
        }; 
        /$pid  $tid.*Leave<[0-9]+>/ {
            if (treated == 0) {
                methodname = \$8
                treated = 1;
                if (count > 0) {
                    count--;
                    tmpcount = count;
                    pattern = \$2\"  \"\$3\" \"\$4\" \"\$5\" \";
                    flag = 0;
                    while (tmpcount > 0) {
                        if (flag == 0) {
                            pattern = pattern \"  \";
                            flag = 1;
                        } else {
                            pattern = pattern \"  \";
                            flag = 0;
                        }
                        tmpcount--;
                    }
                    gsub(/[0-9]+[[:space:]]+[0-9]+[[:space:]]+[A-Z][[:space:]]+[^:]+(:|::) /,pattern);
                    if ($CREATEFOLDER == 1) {
                        gsub(/$/,\"\n\\\"          \"methodname\"--------}}}\");
                    }
                }; 
            }
        };
        /$pid  $tid/ {
            if (treated == 0 && count > 0) {
                tmpcount = count;
                pattern = \$2\"  \"\$3\" \"\$4\" \"\$5\" \";
                flag = 0;
                while (tmpcount > 0) {
                    if (flag == 0) {
                        pattern = pattern \"  \";
                        flag = 1;
                    } else {
                        pattern = pattern \"  \";
                        flag = 0;
                    }
                    tmpcount--;
                }
                gsub(/[0-9]+[[:space:]]+[0-9]+[[:space:]]+[A-Z][[:space:]]+[^:]+(:|::) /,pattern);
            };
        };
        treated = 0;
        {print \$0}
        " $file >> $TMPFILE
}
#############################################################################################
# End of function
#############################################################################################

#############################################################################################
# Function checkFormat
# Parameters: $1 file to be handled
#############################################################################################
function checkFormat() {
    local precontent=$(egrep 'Enter<[0-9]+>' $1 | sed -n '1p' | sed -r 's/: [^:]*Enter<[0-9]+>.*$//g')
    if [ $(echo $precontent | awk '{print NF}') -ne 6 ]; then
        echo "illegal format, please \"logcat -v threadtime to get the logfile\""
        exit 1
    fi
}
#############################################################################################
# End of function
#############################################################################################

##############################################################################################
# step 1: find out all pid and tid that generated the log, and write them to /tmp/pid_tid_file
##############################################################################################
checkFormat $1
cp -v $1 ${1}_formated
declare TMP_PID_TID_FILE="/tmp/pid_tid_file"
declare -i PID
declare -i TID
declare -i CREATEFOLDER=0
declare CUTPATTERN="^[^:]*:"
sed -i "s/$CUTPATTERN//g" ${1}_formated #after handle, the log would look like this "11:02.068  4051  4064 D MC_MEMORY: ************"
if [ $# -eq 3 ]; then
    PID=$2
    TID=$3
    if grep -q "$PID  $TID" ${1}_formated; then
        echo "pid = $PID ; tid = $TID"
        cat -n ${1}_formated | grep "$PID  $TID" > ${1}_${PID}_${TID}
        sed -i -r 's/^[[:space:]]*[0-9]+[[:space:]]*/&underlinereplacehjy/g' ${1}_${PID}_${TID}
        sed -i 's/[[:space:]]*underlinereplacehjy/_hjy/g' ${1}_${PID}_${TID}
        sed -i 's/^/_:/g' ${1}_${PID}_${TID}
        $0 ${1}_${PID}_${TID}
        sed -i 's/_hjy/ /g' ${1}_${PID}_${TID}_formated
        rm -f ${1}_${PID}_${TID}
        exit 0
    fi
fi

declare -i MAXNAMELENGTH=0
MAXNAMELENGTH=$(awk "BEGIN { name = 0; maxname = 0;};
     /[0-9]+[[:space:]]+[0-9]+[[:space:]]+[A-Z][[:space:]]+.*:[[:space:]]+.*(Enter|Leave|Create)<[0-9]+>/ {
         name = length(\$1\$3\$5);
         if (name > maxname) {
             maxname = name;
         };
     };
     END {print maxname}" ${1}_formated)
echo "MAXNAMELENGTH = $MAXNAMELENGTH"
awk "BEGIN { name = 0; namegap = 0; treated = 0; pattern = \"\"; append = 0};
     /[0-9]+[[:space:]]+[0-9]+[[:space:]]+[A-Z][[:space:]]+.*:[[:space:]]+/ {
         treated = 1;
         append = 0;
         name = length(\$1\$3\$5);
         namegap = $MAXNAMELENGTH - name;
         if (index(\$5\"__\",\":\") == 0) {
             append = 1;
             namegap--;
         };
         pattern = \$2\"  \"\$3\" \"\$4\" \";
         while (namegap > 0) {
             pattern = pattern \".\";
             namegap--;
         };
         pattern = pattern \$5;
         if (append == 1) {
             append = 0;
             pattern = pattern\":\";
         };
         gsub(/[0-9]+[[:space:]]+[0-9]+[[:space:]]+[A-Z][[:space:]]+[^:]+:/,pattern);
         print \$0
     };
     /[0-9]+[[:space:]]+[0-9]+[[:space:]]+[A-Z][[:space:]]+.*:[[:space:]]+/ {
         if (treated == 0) {
             print \$0
         } else {
             treated = 0;
         }
     }
     " ${1}_formated >> $TMPFILE
mv $TMPFILE ${1}_formated
egrep '(Enter<[0-9]+>|Leave<[0-9]+>)' ${1}_formated | awk '{print $2 "_" $3}' | sort | uniq -c | awk '{print $2}'> $TMP_PID_TID_FILE

declare -i COUNT=$(wc -l $TMP_PID_TID_FILE | awk '{print $1}')
if [ $COUNT -eq 1 ]; then
    CREATEFOLDER=1
    # CREATEFOLDER=0
else
    CREATEFOLDER=0
fi
tput setf 2
echo "$COUNT pid_tid to handle"
tput setf 7

sed -i 's/_/ /g' $TMP_PID_TID_FILE
declare -i innercount=1
tput setf 2
while [ $innercount -le $COUNT ]
do
    PID=$(sed -n "${innercount}p" $TMP_PID_TID_FILE | awk '{print $1}')
    TID=$(sed -n "${innercount}p" $TMP_PID_TID_FILE | awk '{print $2}')
    echo "($innercount/$COUNT)begin to handle $PID  $TID, lines = $(grep "$PID  $TID" ${1}_formated | wc -l), wait..."
    handleSinglePidTid ${1}_formated $PID $TID
    innercount=$(($innercount + 1))
    mv $TMPFILE ${1}_formated
done
tput setf 7
ENDTIME=$(date +%s)
echo -n "finished: "
echo "$((($ENDTIME - $STARTTIME) / 3600))h $((($ENDTIME - $STARTTIME) % 3600 / 60))m $((($ENDTIME - $STARTTIME) % 60))s"