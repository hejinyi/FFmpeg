#!/bin/bash
#
#Program:
#	This program is used to generate the filenametags that used
# by lookupfile plugin for vim
#
#History:
#	2013/10/27 	gary 	First release


export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/gary/Myscript"

if [ $# -lt 1 ]; then
		echo "You must input the directory where to find files and put the generated tagfile."
		echo "  Usage: "
		echo -e "\t\tfileNameTagsForLookupfile.sh dir"
		exit 1
elif [ $# -gt 1 ]; then
		echo "Too much argument. You must only input the directory where to find files and put the generated tagfile."
		echo "  Usage: "
		echo "fileNameTagsForLookupfile.sh dir"
		exit 1
fi
DESTDIR="$(dirname $1)/$(basename $1)"
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > ${DESTDIR}/filenametags
find ${DESTDIR} -not -regex '.*\.\(png\|gif\)' -type f -printf "%f\t%p\t1\n" | sort -f >> ${DESTDIR}/filenametags
echo "Generated ${DESTDIR}/filenametags"
