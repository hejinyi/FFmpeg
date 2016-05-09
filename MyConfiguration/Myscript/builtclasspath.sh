#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2014-03-24  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

TMPCLASSPATH="/tmp/.tmpclasspath"
CLASSPATHFILE="./.classpath"
rm -f $CLASSPATHFILE
find . -name '.classpath' > $TMPCLASSPATH
sed -i 's/^\.\///g' $TMPCLASSPATH
sed -i 's/\/\.classpath//g' $TMPCLASSPATH

declare -i files=$(wc -l $TMPCLASSPATH | awk '{print $1}')
echo "files = $files"
declare -i count=1
declare PREFIX=""
while [ $count -le $files ]
do
    PREFIX=$(sed -n "${count}p" $TMPCLASSPATH)
    cp -v ${PREFIX}/.classpath ${PREFIX}/.tmpclasspath
    tmpprefix=$(echo $PREFIX | sed 's/\//hejinyi/g')
    if [ -z "$(echo ${PREFIX} | grep 'eclipse$')" ]; then
        sed -i "/classpathentry.*kind=\"src\".*path=\"[^\/].*\"/s/ path=\"/&${tmpprefix}\//g" ${PREFIX}/.tmpclasspath
        sed -i "/classpathentry.*kind=\"output\".*path=\"[^\/].*\"/s/ path=\"/&${tmpprefix}\//g" ${PREFIX}/.tmpclasspath
        sed -i "/classpathentry.*kind=\"lib\".*path=\"[^\/].*\"/s/ path=\"/&${tmpprefix}\//g" ${PREFIX}/.tmpclasspath
        sed -i "/classpathentry.*kind=\"src\".*path=\"\"/s/ path=\"/&${tmpprefix}\//g" ${PREFIX}/.tmpclasspath
        sed -i "/classpathentry.*kind=\"output\".*path=\"\"/s/ path=\"/&${tmpprefix}\//g" ${PREFIX}/.tmpclasspath
        sed -i "/classpathentry.*kind=\"lib\".*path=\"\"/s/ path=\"/&${tmpprefix}\//g" ${PREFIX}/.tmpclasspath
        sed -i "/classpathentry/s/\/\//\//g" ${PREFIX}/.tmpclasspath
        sed -i 's/hejinyi/\//g' ${PREFIX}/.tmpclasspath
    fi
    if [ $count -eq 1 ]; then
        sed -i '/<\/classpath>/d' ${PREFIX}/.tmpclasspath
        cat ${PREFIX}/.tmpclasspath > $CLASSPATHFILE
    elif [ $count -lt $files ]; then
        sed -i '/version.*encoding/d' ${PREFIX}/.tmpclasspath
        sed -i '/<classpath>/d' ${PREFIX}/.tmpclasspath
        sed -i '/<\/classpath>/d' ${PREFIX}/.tmpclasspath
        cat ${PREFIX}/.tmpclasspath >> $CLASSPATHFILE
    else
        sed -i '/xml.*encoding/d' ${PREFIX}/.tmpclasspath
        sed -i '/<classpath>/d' ${PREFIX}/.tmpclasspath
        cat ${PREFIX}/.tmpclasspath >> $CLASSPATHFILE
    fi
    rm -f ${PREFIX}/.tmpclasspath
    count=$(($count + 1))
done
cp -v $CLASSPATHFILE ${CLASSPATHFILE}_bak
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $CLASSPATHFILE
echo "<classpath>" >> $CLASSPATHFILE
if [ "$1" == "simple" ]; then
    grep '<classpathentry.*/>' ${CLASSPATHFILE}_bak | sed -n '/kind="src"/p'| sed -n '/combineaccessrules=".*"/! p' >> $CLASSPATHFILE
else
    # grep '<classpathentry.*/>' ${CLASSPATHFILE}_bak | sort >> $CLASSPATHFILE
    grep '<classpathentry.*/>' ${CLASSPATHFILE}_bak >> $CLASSPATHFILE
fi
echo "</classpath>" >> $CLASSPATHFILE
sed -i '/^[[:space:]]*$/d' ${CLASSPATHFILE}
sed -i '/cts\//d' ${CLASSPATHFILE}
sed -i '/\/tests\//d' ${CLASSPATHFILE}
rm -f ${CLASSPATHFILE}_bak

echo -en "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" > .project
echo -en "<projectDescription>\n" >> .project
echo -en "\t<name>" >> .project
projectname=$(pwd | xargs basename)
echo -en "$projectname" >> .project
echo -en "</name>\n" >> .project
echo -en "\t<comment></comment>\n" >> .project
echo -en "\t<projects>\n" >> .project
echo -en "\t</projects>\n" >> .project
echo -en "\t<buildSpec>\n" >> .project
echo -en "\t\t<buildCommand>\n" >> .project
echo -en "\t\t\t<name>org.eclipse.jdt.core.javabuilder</name>\n" >> .project
echo -en "\t\t\t<arguments>\n" >> .project
echo -en "\t\t\t</arguments>\n" >> .project
echo -en "\t\t</buildCommand>\n" >> .project
echo -en "\t</buildSpec>\n" >> .project
echo -en "\t<natures>\n" >> .project
echo -en "\t\t<nature>org.eclipse.jdt.core.javanature</nature>\n" >> .project
echo -en "\t</natures>\n" >> .project
echo -en "</projectDescription>\n" >> .project
