#!/bin/bash
#
# Program:
#   This script is used to 
#
# History:
#   2014-03-24  gary    First release
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin"

CLASSPATHFILE=".classpath"
rm -f $CLASSPATHFILE

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $CLASSPATHFILE
echo "<classpath>" >> $CLASSPATHFILE
find . -regex '.*\/\(src\|java\)$' -type d | egrep -v '(/tests/|/test/)' | xargs -n 1 -I % echo "    <classpathentry kind=\"src\" path=\"%\"/>" >> $CLASSPATHFILE
echo "</classpath>" >> $CLASSPATHFILE

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
