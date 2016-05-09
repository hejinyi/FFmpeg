#!/bin/bash
#
# Program:
#   This script is used to generate the tags file, lookupfile tags file, cscope.files, so that vim can work efficiently. 
#
# History:
#   2013-11-07  gary    First release
#


export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

function usage() {
    echo "  Do nothing."
    echo "  Usage:"
    echo -e "\tctag_cscope_lookupfile_set.sh"
    echo -e "\tctag_cscope_lookupfile_set.sh ctags"
    echo -e "\tctag_cscope_lookupfile_set.sh cscope"
    echo -e "\tctag_cscope_lookupfile_set.sh lookupfile"
    echo -e "\tctag_cscope_lookupfile_set.sh clean"
    exit 1
}

tput setf 4
if [ $# -gt 1 ]; then
    usage
fi

if [ $# -eq 1 ]; then
    if [ "$1" != "ctags" -a "$1" != "cscope" -a "$1" != "lookupfile" -a "$1" != "clean" ]; then
        usage
    fi
fi
tput setf 7

declare -i STARTTIME
STARTTIME=$(date +%s)

CTAGSFILENAME=fileIn$(basename $(pwd))
LOOKUPFILENAME=hejinyiFilenametags
CSCOPEFILENAME=cscope.files
TAGS=tags
CURRENTDIR=$(pwd)
FILESEPARATOR=____hejinyi____

if [ "$1" == "lookupfile" -o $# -eq 0 -o "$1" == "clean" ]; then
    tput setf 4
    if [ -f $LOOKUPFILENAME ]; then
        rm -f $LOOKUPFILENAME 
        echo "$LOOKUPFILENAME has been exit. delete it..."
    fi
    if [ "$1" != "clean" ]; then
        tput setf 2
        echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > $LOOKUPFILENAME
        #find $(pwd) -regex '.*\.\(c\|C\|c++\|C++\|cpp\|CPP\|java\|jar\|mk\)$' -type f -printf "%f\t%p\t1\n" | sort -f >> $LOOKUPFILENAME
        find $(pwd) -regex '.*\(\.h\|\.c\|\.C\|\.cxx\|\.cp\|\.cc\|\.cpp\|\.c++\|\.C++\|\.hpp\|\.java\|\.xml\|\.mk\|\.kl\|\.mak\|makefile\|Makefile\)$' -type f -printf "%f${FILESEPARATOR}%p${FILESEPARATOR}1\n" | sort -f >> $LOOKUPFILENAME
        #find $(pwd) -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.java" -o -name "*.cpp" -o -name "*.xml" -o -name "*.kl" -o -name "*.mk" -o -name "*.mak" -o -name "makefile" -o -name "Makefile" -printf "%f\t%p\t1\n" | sort -f >> $LOOKUPFILENAME
        echo "Generated ${CURRENTDIR}/$LOOKUPFILENAME"

        tput setf 7
    fi
fi

if [ "$1" == "ctags" -o $# -eq 0 -o "$1" == "clean" ]; then
    tput setf 4
    if [ -f $CTAGSFILENAME ]; then
        rm -f $CTAGSFILENAME
        echo "$CTAGSFILENAME has been exit. delete it..."
    fi
    if [ -f $TAGS ]; then
        rm -f $TAGS 
        echo "$TAGS has been exit. delete it..."
    fi
    if [ "$1" != "clean" ]; then
        tput setf 2
        #find ${CURRENTDIR} -type f > $CTAGSFILENAME
        cat $LOOKUPFILENAME | awk -F $FILESEPARATOR '{print $2}' | sed '1d' > $CTAGSFILENAME
        echo "Generated ${CURRENTDIR}/$CTAGSFILENAME"
        ctags-exuberant -L $CTAGSFILENAME &
        echo "Generated $CURRENTDIR/$TAGS"
        tput setf 7
    fi
fi

if [ "$1" == "cscope" -o $# -eq 0 -o "$1" == "clean" ]; then
    tput setf 4
    CSCOPEFILENAME_TMP=$(ls cscope* 2> /dev/null)
    if [ ! -z "$CSCOPEFILENAME_TMP" ]; then
        for var in $CSCOPEFILENAME_TMP
        do
            echo "$var has been exit. delete it..."
            rm -f $var 
        done
    fi
    if [ "$1" != "clean" ]; then
        tput setf 2
        #find ${CURRENTDIR} -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.java" -o -name "*.cpp" -o -name "*.xml" -o -name "*.kl" -o -name "*.mk" -o -name "*.mak" -o -name "makefile" -o -name "Makefile" > $CSCOPEFILENAME
        cat $LOOKUPFILENAME | awk -F $FILESEPARATOR '{print $2}' | sed '1d' > $CSCOPEFILENAME
        sed -i 's/^/"/g' $CSCOPEFILENAME
        sed -i 's/$/"/g' $CSCOPEFILENAME
        echo "Generated ${CURRENTDIR}/$CSCOPEFILENAME"
        cscope -bq &
        CSCOPEFILENAME_TMP=$(ls cscope* 2> /dev/null)
        if [ ! -z "$CSCOPEFILENAME_TMP" ]; then
            for var in $CSCOPEFILENAME_TMP
            do
                echo "Generated $var"
            done
        else
            tput setf 4
            echo "cscope failed generate cscope.in.out, cscope.out. cscope.po.out."
        fi
        tput setf 7
    fi
fi

tput setf 6

if [ -f $LOOKUPFILENAME ]; then
    sed -i "s/$FILESEPARATOR/\t/g" $LOOKUPFILENAME
fi
rm -f $CTAGSFILENAME

wait
ENDTIME=$(date +%s)
echo -e "\nTotalTime: $((($ENDTIME - $STARTTIME) / 3600))h $((($ENDTIME - $STARTTIME) % 3600 / 60))m $((($ENDTIME - $STARTTIME) % 60))s"
tput setf 7
exit 0
