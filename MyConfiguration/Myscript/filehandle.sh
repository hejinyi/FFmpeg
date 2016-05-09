#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2013-12-15  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

declare -i STARTLINE
declare -i ENDLINE
###############################################################
# Function Name: findBlock
# Parameters: $1 left brace or right brace (left/right)
#             $2 original file
#             $3 start line where to begin to find the block
# Usage: findBlock $FINDTYPE $FILENAME $LINENUMBER ["startline"]
# Author: Gary
# Time: 2013-12-14
###############################################################
function findBrace() {
    local -i line
    local -i count
    local contentvar
    local file
    local type

    type=$1
    file=$2
    line=$3

    if [ "$type" == "left" ]; then
        count=0
        contentvar=$(sed -n "${line}p" ${file})
        count=$(($count + $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | sed 's/[^}]//g' | wc -m) - 1))
        count=$(($count - $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | sed 's/[^{]//g' | wc -m) + 1))
        while [ ${count} -ne 0 ]
        do
            line=$((${line} - 1))
            contentvar=$(sed -n "${line}p" ${file})
            count=$(($count + $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | sed 's/[^}]//g' | wc -m) - 1))
            count=$(($count - $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | sed 's/[^{]//g' | wc -m) + 1))
        done
    elif [ "$type" == "right" ]; then
        count=0
        contentvar=$(sed -n "${line}p" ${file})
        count=$(($count + $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | sed 's/[^{]//g' | wc -m) - 1))
        count=$(($count - $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | sed 's/[^}]//g' | wc -m) + 1))
        while [ ${count} -ne 0 ]
        do
            line=$((${line} + 1))
            contentvar=$(sed -n "${line}p" ${file})
            count=$(($count + $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | sed 's/[^{]//g' | wc -m) - 1))
            count=$(($count - $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | sed 's/[^}]//g' | wc -m) + 1))
        done
    fi
    GLOBALLINE=$line
}

###############################################################
# END OF FUNCTION
###############################################################

###############################################################
# Function Name: findBlock
# Parameters: $1 type to be find (methodBlock/classBlock)
#             $2 original file
#             $3 start line where to begin to find the block
#             $4 when we only want STARTLINE, populate this parameter with "startline" 
# Usage: findBlock $FINDTYPE $FILENAME $LINENUMBER ["startline"]
# Author: Gary
# Time: 2013-12-03
###############################################################
function findBlock() {
    local -i LINE=$3
    local -i LINEBACKUP=$3
    local DETECTSUPER="false"
    local DETECTRETURN="false"
    local FILE=$2
    local TYPE=$1
    local CONTENTVAR=""
    local -i COUNT=1
    local ISCOMMENT="false"
    STARTLINE=$LINE
    ENDLINE=$LINE
    if [ "$TYPE" == "methodBlock" ]; then

        if [ $DEBUG == "true" ]; then
            echo "***** Begin to find methodBlock for ($METHODNAME, Singleline = $LINE) *****"
        fi
        echo "***** Begin to find methodBlock for ($METHODNAME, Singleline = $LINE) *****" >> $LOGFILE

        CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep '[;{]')
        while [ -z "${CONTENTVAR}" ]
        do
            LINE=$((${LINE} + 1))
            CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep '[;{]')
            if [ $DEBUG == "true" ]; then
                echo "while 1, find { for methodBlock ($METHODNAME, Line = $LINE)"
            fi
            echo "while 1, find { for methodBlock ($METHODNAME, Line = $LINE)" >> $LOGFILE
        done
            
        if [ $LINE -ne $3 ]; then
            METHODNAME=$(echo "${METHODNAME1}()")
        fi

        if [ -z "$(echo ${CONTENTVAR} | grep '{')" ]; then
            ISABSTRACTMETHOD="true"
            STARTLINE=0
            ENDLINE=0
        elif [ ! -z "$(echo $CONTENTVAR | grep '{.*}')" ]; then
            ISSINGLELINEMETHOD="true"
            STARTLINE=0
            ENDLINE=0
        else
            LINEBACKUP=$LINE
            LINE=$((${LINE} + 1))
            CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep -v 'super\(.*|this\(.*|^$')
            if [ ! -z "$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep 'super\(.*|this\(.*')" ]; then
                DETECTSUPER="true"
            fi
            while [ -z "${CONTENTVAR}" ]
            do
                LINE=$((${LINE} + 1))
                if [ $DETECTSUPER == "false" ]; then
                    CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep -v 'super\(.*|this\(.*|^$')
                else
                    CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/""/g' | sed 's/\/\/.*/;/g' | egrep -v -n 'super\(.*|this\(.*')
                fi
                if [ $DEBUG == "true" ]; then
                    echo "while 2, try to skip super() or this() or blankline ($METHODNAME, Line = $LINE)"
                fi
                echo "while 2, try to skip super() or this() or blankline ($METHODNAME, Line = $LINE)" >> $LOGFILE
                if [ ! -z "$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep 'super\(.*|this\(.*')" ]; then
                    DETECTSUPER="true"
                fi
            done
            LINE=$((${LINE} - 1))
            if [ $DETECTSUPER == "true" -a -z "$(echo $CONTENTVAR | grep '}')" ]; then
                CONTENTVAR=$(sed -n "${LINE}p" $FILE | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep ';')
                while [ -z "$CONTENTVAR" ]
                do
                    LINE=$((${LINE} + 1))
                    CONTENTVAR=$(sed -n "${LINE}p" $FILE | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep ';')
                    if [ $DEBUG == "true" ]; then
                        echo "while 2-1, super() is defined in multilines, try to find (;) ($METHODNAME, Line = $LINE)"
                    fi
                    echo "while 2-1, super() is defined in multilines, try to find (;) ($METHODNAME, Line = $LINE)" >> $LOGFILE
                done
            fi
            DETECTSUPER="false"
            STARTLINE=$LINE
            if [ "$4" == "startline" ]; then
                return
            fi
            LINE=$LINEBACKUP
            findBrace "right" $FILE $LINE
            LINE=$GLOBALLINE


            LINE=$((${LINE} - 1))
            CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep -v 'return;|return[[:space:]]+.*;|return.*{.*}|return\(.*\).*;|throw[[:space:]]+.*;|throw.*{.*}|^$')
            if [ ! -z "$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep 'return;|return[[:space:]]+.*;|return\(.*\).*;|return.*{.*}|throw[[:space:]]+.*;')" ]; then
                DETECTRETURN="true"
                LINE=$((${LINE} - 1))
            else
                DETECTRETURN="false"
            fi
            while [ -z "${CONTENTVAR}" -a $DETECTRETURN == "false" ]
            do
                LINE=$((${LINE} - 1))
                if [ $DETECTRETURN == "false" ]; then
                    CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep -v 'return;|return[[:space:]]+.*;|return.*{.*}|return\(.*\).*;|throw[[:space:]]+.*;|throw.*{.*}|^$')
                else
                    CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep -v -n 'return;|return[[:space:]]+.*;|return.*{.*}|return\(.*\).*;|throw[[:space:]]+.*;|throw.*{.*}')
                fi
                if [ $DEBUG == "true" ]; then
                    echo "while 4, try to skip return or blankline ($METHODNAME, Line = $LINE)"
                fi
                echo "while 4, try to skip return or blankline ($METHODNAME, Line = $LINE)" >> $LOGFILE
                if [ ! -z "$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep 'return;|return[[:space:]]+.*;|return\(.*\).*;|return.*{.*}|throw[[:space:]]+.*;')" ]; then
                    DETECTRETURN="true"
                    LINE=$((${LINE} - 1))
                else
                    DETECTRETURN="false"
                fi
            done
            if [ "$DETECTRETURN" == "true" -o ! -z "$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep ';[[:space:]]*$')" ]; then
                UNREACHEDABLE="false"
            else
                UNREACHEDABLE="unknow"
            fi

            if [ -z "$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep '}' | grep -v ';[[:space:]]*$')" -a $DETECTRETURN == "false" ]; then
                if [ ! -z "$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep '}[[:space:]]*;[[:space:]]*$')" ]; then
                    findBrace "left" $FILE $LINE
                    LINE=$GLOBALLINE
                fi
                COUNT=1
                LINE=$((${LINE} - 1))
                CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/^[[:space:]]*\/\/.*/;/g' | sed 's/\/\/.*//g' |  egrep -n '[;}{]|^$')
                while [ -z "${CONTENTVAR}" ]
                do
                    LINE=$((${LINE} - 1))
                    COUNT=$((${COUNT} + 1))
                    CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/^[[:space:]]*\/\/.*/;/g' | sed 's/\/\/.*//g' | egrep -n '[;}{]|^$')
                    if [ $DEBUG == "true" ]; then
                        echo "while 5, a statement with multilines, keep searching to determine if it is a return statement ($METHODNAME, Line = $LINE)"
                    fi
                    echo "while 5, a statement with multilines, keep searching to determine if it is a return statement ($METHODNAME, Line = $LINE)" >> $LOGFILE
                done
                LINE=$((${LINE} + 1))
                COUNT=$(($COUNT - 1))
                CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | egrep 'return;|return[[:space:]]+|return\(.*|throw[[:space:]]+')
                if [ -z "$CONTENTVAR" ]; then
                    LINE=$(($LINE + $COUNT))
                else
                    LINE=$(($LINE - 1))
                fi
            fi
            LINE=$((${LINE} + 1))
            ENDLINE=$((${LINE} + 1))
            if [ $DEBUG == "true" ]; then
                echo "methodBlock determined successed ($METHODNAME): startline = $STARTLINE, endline = $ENDLINE"
            fi
            echo "methodBlock determined successed ($METHODNAME): startline = $STARTLINE, endline = $ENDLINE" >> $LOGFILE
        fi
    elif [ "$TYPE" == "classBlock" ]; then
        if [ $DEBUG == "true" ]; then
            echo "***** Begin to find classBlock for ($PRIVATECLASS, Singleline = $LINE) *****"
        fi
        echo "***** Begin to find classBlock for ($PRIVATECLASS, Singleline = $LINE) *****" >> $LOGFILE
        CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep '{')
        while [ -z "${CONTENTVAR}" ]
        do
            LINE=$((${LINE} + 1))
            CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep '{')
            if [ $DEBUG == "true" ]; then
                echo "while 6, find { for classBlock ($PRIVATECLASS, Line = $LINE)"
            fi
            echo "while 6, find { for classBlock ($PRIVATECLASS, Line = $LINE)" >> $LOGFILE
        done
        STARTLINE=$LINE
        if [ "$4" == "startline" ]; then
            return
        fi
        findBrace "right" $FILE $LINE
        LINE=$GLOBALLINE
        ENDLINE=$LINE
        if [ $DEBUG == "true" ]; then
            echo "classBlock determined successed ($PRIVATECLASS): Startline = $STARTLINE, Endline = $ENDLINE"
        fi
        echo "classBlock determined successed ($PRIVATECLASS): Startline = $STARTLINE, Endline = $ENDLINE" >> $LOGFILE
    elif [ "$TYPE" == "inclassBlock" ]; then
        CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep '}')
        while [ -z "$CONTENTVAR" ]
        do
            LINE=$(($LINE + 1))
            CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep '}')
            if [ $DEBUG == "true" ]; then
                echo "while 13, find } for inclassBlock (Line = $LINE)"
            fi
            echo "while 13, find } for inclassBlock (Line = $LINE)" >> $LOGFILE
        done
        ENDLINE=$LINE
        findBrace left $FILE $LINE
        LINE=$GLOBALLINE
        # STARTLINE=$LINE
        LINE=$(($LINE - 1))
        CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep -v '^[[:space:]]*$' | egrep '[;{}][[:space:]]*$')
        while [ -z "$CONTENTVAR" ]
        do
            LINE=$(($LINE - 1))
            CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep -v '^[[:space:]]*$' | egrep -n '[;{}][[:space:]]*$')
        done
        LINE=$(($LINE + 1))
        CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g' | grep -v '^[[:space:]]*$')
        while [ -z "$CONTENTVAR" ]
        do
            LINE=$(($LINE + 1))
            CONTENTVAR=$(sed -n "${LINE}p" ${FILE} | sed 's/"[^"]*"/ /g' | sed 's/\/\/.*//g')
        done
        STARTLINE=$LINE
    fi
}
###############################################################
# End of function
###############################################################
###############################################################
# Function Name: findBlock
# Parameters: $1 left brace or right brace (left/right)
#             $2 original file
#             $3 start line where to begin to find the block
# Usage: findBlock $FINDTYPE $FILENAME $LINENUMBER ["startline"]
# Author: Gary
# Time: 2013-12-14
###############################################################
function findBrace() {
    local -i line
    local -i count
    local contentvar
    local file
    local plus
    local sub
    local direction
    if [ "$1" == "leftbrace" ]; then
        plus="}"
        sub="{"
        direction="up"
    elif [ "$1" == "rightbrace" ]; then
        plus="{"
        sub="}"
        direction="down"
    elif [ "$1" == "leftparentheses" ]; then
        plus=")"
        sub="("
        direction="up"
    elif [ "$1" == "rightparentheses" ]; then
        plus="("
        sub=")"
        direction="down"
    fi

    file=$2
    line=$3

    count=0
    contentvar=$(sed -n "${line}p" ${file})
    count=$(($count + $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/^[[:space:]]*\/\/.*//g' | sed 's/\/\/.*//g' | sed "s/[^${plus}]//g" | wc -m) - 1))
    count=$(($count - $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/^[[:space:]]*\/\/.*//g' | sed 's/\/\/.*//g' | sed "s/[^${sub}]//g" | wc -m) + 1))
    while [ ${count} -gt 0 ]
    do
        if [ "$direction" == "up" ]; then
            line=$((${line} - 1))
        else
            line=$((${line} + 1))
        fi
        contentvar=$(sed -n "${line}p" ${file})
        count=$(($count + $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/^[[:space:]]*\/\/.*//g' | sed 's/\/\/.*//g' | sed "s/[^${plus}]//g" | wc -m) - 1))
        count=$(($count - $(echo ${contentvar} | sed 's/"[^"]*"/ /g' | sed 's/^[[:space:]]*\/\/.*//g' | sed 's/\/\/.*//g' | sed "s/[^${sub}]//g" | wc -m) + 1))
    done
    GLOBALLINE=$line
}

###############################################################
# END OF FUNCTION
###############################################################
###########################begin of function###################

declare -i wl
declare -i lineoffile
declare file
file=$1
declare line
declare contentvar
declare -i localstartline
declare -i localendline
declare filehandletmpfile
filehandletmpfile=/tmp/.filehandletmpfile


    sed -i 's/\/\/.*//g' $file
    sed -i 's/"[^"]*"/" "/g' $file
    sed -i '/^[[:space:]]*$/d' $file

    wl=$(sed -n '1,$p' $file | grep ')[^}]*;[[:space:]]*$' | wc -l | awk '{print $1}')

    while [ $wl -ne 0 ]
    do
        line=$(sed -n '1,$p' $file | grep -n ')[^}]*;[[:space:]]*$' | grep -v 'hejinyi' | sed -n '$p' | cut -d ':' -f 1)
        findBrace leftparentheses $file $line
        sed -i "${STARTLINE},${ENDLINE}s/)/}g" $file
        sed -i "${STARTLINE},${ENDLINE}s/(/{g" $file
        wl=$(sed -n '1,$p' $file | grep ')[^}]*;[[:space:]]*$' | wc -l | awk '{print $1}')
    done

wl=$(sed -n '1,$p' $file | grep '}[[:space:]]*;[[:space:]]*$' | grep -v 'hejinyi' | wc -l | awk '{print $1}')

while [ $wl -ne 0 ]
do
    line=$(sed -n '1,$p' $file | grep -n '}[[:space:]]*;[[:space:]]*$' | grep -v 'hejinyi' | sed -n '$p' | cut -d ':' -f 1)
    echo "line = $line"
    findBlock "inclassBlock" $file $line
    localstartline=$(($STARTLINE - 1))
    localendline=$(($ENDLINE + 1))
    lineoffile=$(wc -l $file | awk '{print $1}')
    sed -n "1,${localstartline}p" $file > $filehandletmpfile
    contentvar=$(sed -n "${STARTLINE},${ENDLINE}p" $file)
    echo $contentvar >> $filehandletmpfile
    sed -n "${localendline},${lineoffile}p" $file >> $filehandletmpfile
    mv $filehandletmpfile $file
    sed -i "${STARTLINE}s/$/hejinyi/g" $file
    wl=$(sed -n '1,$p' $file | grep '}[[:space:]]*;[[:space:]]*$' | grep -v 'hejinyi' | wc -l | awk '{print $1}')
done
sed -i 's/hejinyi//g' $file
 
while [ ! -z "$(grep 'while[[:space:]]*([[:space:]]*true[[:space:]]*)' $file)" ]
do
    line=$(grep -n 'while[[:space:]]*([[:space:]]*true[[:space:]]*)' $file | sed '$p' | cut -d ':' -f 1)
    findBlock "classBlock" $fine $line
    localstartline=$STARTLINE
    localendline=$ENDLINE
    sed -i "${STARTLINE},${ENDLINE}d" $file
    sed -i "${line}a return;" $file
done
