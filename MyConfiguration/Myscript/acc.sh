#!/bin/bash
#
#Program:
#	This program is used to compile the android project. Before you run this script, you must go to the android project directory, what's more, this script will add two files, .project and .classpath, to the current project, so that eclipse can run the porject too. For this, there must be the two files in /home/gary/workspace, and the third line of .project are "<name>projectname</name>". PS: with no double quotes.  
#   This script run with no argument or accept one argument (only "logcat" accepted). You can run this script in shell command, or you can also use the shortcut key ",ca"(no argument mode) or ",cl"(with "logcat" as the argument) in vim to run it.
#
#History:
#	2013/10/29 	gary    First release


export JAVA_HOME=/home/gary/java/jdk1.6.0_37
export JRE_HOME=/home/gary/java/jdk1.6.0_37/jre
export CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib:$JRE_HOME/lib
export ANDROIDSDK_HOME=/home/gary/java/Android_SDK
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$JAVA_HOME/bin:$JRE_HOME/bin:/home/gary/bin:$ANDROIDSDK_HOME/tools:$ANDROIDSDK_HOME/platform-tools:$ANDROID_HOME/build-tools/android-4.3:/home/gary/Myscript"

PACKAGENAME=$(grep 'package' ./AndroidManifest.xml | cut -d "=" -f 2 | sed 's/"//g')
ACTIVITY=$(basename $(pwd))
KEYSTORE="/home/gary/java/gary.keystore"
KEYALIAS="gary.keystore"
STOREPASS="123465"
SIGNEDAPK="./bin/${ACTIVITY}_gary.apk"
RELEASEAPK="./bin/${ACTIVITY}-release-unsigned.apk"
ZIPALIGNAPK="./bin/${ACTIVITY}_gary_zip.apk"

function Usage() {
    tput setf 2
    echo "  Usage:"
    echo -e "\ttype 1: with no argument"
    echo -e "\t\t$(basename $1)"
    echo -e "\ttype 2: with one argument (only \"logcat\" accepted)"
    echo -e "\t\t$(basename $1) logcat"
    tput setf 7
}

if [ ! -f ./AndroidManifest.xml ]; then
    tput setf 4
    echo -e "\n*****Error: There is no android project in $(pwd)*****\n"
    tput setf 7
	exit 1
fi
if [ $# -gt 1 ]; then
    tput setf 4
    echo -e "\n*****Error: Too much arguments*****"
    tput setf 7
    Usage $0
    exit 1
elif [ $# -eq 1 ]; then
    if [ "$1" != "logcat" ]; then
        Usage $0
        exit 1
    fi
fi


if [ ! -f .project -o ! -f .classpath ]; then
    if [ ! -f /home/gary/workspace/.project ]; then
        tput setf 6
        echo "\n*****Info: There is no file .project in /home/gary/workspce, this project will not accepted by Eclipse.*****"
        tput setf 7
    elif [ ! -f /home/gary/workspace/.classpath ]; then
        tput setf 6
        echo "\n*****Info: There is no file .classpath in /home/gary/workspce, this project will not accepted by Eclipse.*****"
        tput setf 7
    else
        cp -v /home/gary/workspace/.project /home/gary/workspace/.classpath .
        sed -i "3s/projectname/${ACTIVITY}/g" .project
    fi
fi


ant clean

if [ "$?" != 0 ]; then
    tput setf 4
	echo -e "\n*****Error: 'ant clean' failed*****\n"
    tput setf 7
	exit 1
fi

ant release

if [ "$?" != 0 ]; then
    tput setf 4
	echo -e "\n*****Error: 'ant release' failed*****\n"
    tput setf 7
	exit 1
fi

jarsigner -verbose -keystore ${KEYSTORE} -storepass ${STOREPASS} -signedjar ${SIGNEDAPK} ${RELEASEAPK} ${KEYALIAS}

if [ "$?" != 0 ]; then
    tput setf 4
	echo -e "\n*****Error: 'jarjarsigner -verbose -keystore ${KEYSTORE} -storepass ${STOREPASS} -signedjar ${SIGNEDAPK} ${RELEASEAPK} ${KEYALIAS}' failed*****\n"
    tput setf 7
	exit 1
fi

zipalign -f -v 4 ${SIGNEDAPK} ${ZIPALIGNAPK}

if [ "$?" != 0 ]; then
    tput setf 4
	echo -e "\n*****Error: 'zipalign -f -v 4 ${SIGNEDAPK} ${ZIPALIGNAPK}' failded*****\n"
    tput setf 7
	exit 1
fi

DEVICEREAL=$(adb devices | grep 'device' | grep -v 'devices' | grep -v 'emu' | awk '{print $1}')
DEVICEEMU=$(adb devices | grep 'device' | grep -v 'devices' | grep 'emu' | awk '{print $1}')
if [ -z "${ANDROID_SDK_HOME}" ]; then
	AVDDIR="${HOME}/.android"
else
	AVDDIR="${ANDROID_SDK_HOME}/.android"
fi

declare -i i=1
if [ ! -z "${DEVICEREAL}" -o ! -z "${DEVICEEMU}" ]; then
    declare -i DEVICESUM
    DEVICESUM=0
	while [ -z "${DEVICE}" ]
	do
        tput setf 2
		echo -e "\nThere are some android devices connected to this computer: "
		i=1
		printf '  %-6s    %-20s    %-20s\n' "Number" "Name" "Type"
		if [ ! -z "${DEVICEREAL}" ]; then
			for var in ${DEVICEREAL}
			do
				printf '  %-6s    %-20s    %-20s\n' ${i} ${var} "Physical android device"
				i=${i}+1
                DEVICESUM=${DEVICESUM}+1
			done
		fi
		if [ ! -z "${DEVICEEMU}" ]; then
			for var in ${DEVICEEMU}
			do
				printf '  %-6s    %-20s    %-20s\n' ${i} ${var} "Emulator AVD"
				i=${i}+1
                DEVICESUM=${DEVICESUM}+1
			done
		fi
        tput setf 7

		declare -i NUMBER
        if [ $DEVICESUM -eq 1 ]; then
            NUMBER=1
        else
            tput setf 2
		    read -p "Please input the number of the device you want to use: " NUMBER
            tput setf 7
        fi

		i=1
		AVAILABLEDEVICE=$(echo "${DEVICEREAL} ${DEVICEEMU}" | tr '\n' ' ')
		for var in ${AVAILABLEDEVICE}
   		do
     		if [ "${i}" == "${NUMBER}" ]; then
     	  	    DEVICE=${var}
	   		fi
	  		i=${i}+1
   		done
		if [ -z "${DEVICE}" ]; then
        tput setf 4
		    echo -e "\n*****Wrong number!*****\n"
        tput setf 7
		fi
	done
else
	AVD=$(ls ${AVDDIR}/avd | grep '.avd' | sed 's/.avd//g')

	if [ -z "${AVD}"  ]; then
        tput setf 4
		echo -e "\n*****Warning: There is no android machine connected to you computer and no AVD in you computer*****\n"
        tput setf 7

		while [ "${NEWAVD}" != "y" -a "${NEWAVD}" != "Y" -a "${NEWAVD}" != "n" -a "${NEWAVD}" != "N" ]
		do
            tput setf 6
			read -p "Do you want to create a new AVD?(y/n): " NEWAVD
            tput setf 7
		done

		if [ "${NEWAVD}" == "n" -o "${NEWAVD}" == "N" ]; then
			exit 0
		else
            tput setf 6
			read -p "input the name of the new AVD: " NEWAVDNAME

			read -p "input the version number of android (default android-8): " ANDROIDVERSION
			if [ -z "${ANDROIDVERSION}" ]; then
				ANDROIDVERSION="android-8"
			fi

			echo -e "\n------------------------------------------------------"
			echo -e "------------------------------------------------------"
			declare -i END=$(android list | cat -n | grep ${ANDROIDVERSION} | awk '{print $1}')+6
			android list | head -n ${END} | tail -n 7
			echo -e "------------------------------------------------------"

			printf '  %-19s %-26s %-29s %-27s %-33s\n\n' "" "Low density (120), ldpi" "Medium density (160), mdpi" "High density (240), hdpi" "Extra high density (xxx) ehdpi"


			printf '  %-19s %-26s %-29s %-27s %-33s\n\n' "Smallscreen" "QVGA (240x320)" "" "480x640" ""


			printf '  %-19s %-26s %-29s %-27s %-33s\n' "Normalscreen" "WQVGA400 (240x400)" "HVGA (320x480)" "WVGA800 (480x800)" "640x960"
			printf '  %-19s %-26s %-29s %-27s %-33s\n' "" "WQVGA432 (240x432)" "" "WVGA854 (480x854)" ""
			printf '  %-19s %-26s %-29s %-27s %-33s\n\n' "" "" "" "600x1024" ""
			

			printf '  %-19s %-26s %-29s %-27s %-33s\n' "Largescreen" "WVGA800** (480x800)" "WVGA800* (480x800)" "" ""
			printf '  %-19s %-26s %-29s %-27s %-33s\n' "" "WVGA854** (480x854)" "WVGA854* (480x854)" "" ""
			printf '  %-19s %-26s %-29s %-27s %-33s\n\n' "" "" "600x1024" "" ""


			printf '  %-19s %-26s %-29s %-27s %-33s\n' "Extra Largescreen" "1024x600" "WXGA (1290x800)" "1536x1152" "2048x1536"
			printf '  %-19s %-26s %-29s %-27s %-33s\n' "" "" "1024x768" "1920x1152" "2660x1536"
			printf '  %-19s %-26s %-29s %-27s %-33s\n' "" "" "1280x768" "1920x1200" "2560x1600"
			echo -e "------------------------------------------------------"
			echo -e "------------------------------------------------------\n"

			read -p "input the resolution of the new AVD (default HVGA(320x480)): " RESOLUTION
			if [ -z "${RESOLUTION}" ]; then
				RESOLUTION="HVGA"
			fi

			read -p "input the CPU architecture of the new AVD (default armeabi-v7a): " CPUARCH
			if [ -z "${CPUARCH}" ]; then
				CPUARCH="armeabi-v7a"
			fi

			read -p "input the capacity of the sdcard of the new AVD (default 256M)" SDCARD
			if [ -z "${SDCARD}" ]; then
				SDCARD="256M"
			fi
            tput setf 7

			android create avd -n ${NEWAVDNAME} -t ${ANDROIDVERSION} -s ${RESOLUTION} -b ${CPUARCH} -c ${SDCARD}
			if [ "$?" != 0 -o "$(android list avd | wc -l)" -lt 2 ]; then
                tput setf 4
				echo -e "\n*****Error: 'android create avd -n ${NEWAVDNAME} -t ${ANDROIDVERSION} -s ${RESOLUTION} -b ${CPUARCH} -c ${SDCARD}' failed*****\n"
                tput setf 7
				exit 1
			fi

			android list avd
			sleep 2s
			AVDNAME=${NEWAVDNAME}
		fi
	else
		until [ ! -z "${AVDNAME}" ]
		do
            tput setf 2
			echo -e "Available AVD in ${AVDDIR} are as following: "
			printf '  %-6s    %-20s    %-20s\n' "Number" "Name" "Type"
			i=1
			for var in ${AVD}
			do
				printf '  %-6s    %-20s    %-20s\n' ${i} ${var} "Emulator AVD"
				i=${i}+1
			done

			declare -i NUMBER
			read -p "Please input the number you want to start: " NUMBER
            tput setf 7

			i=1
			for var in ${AVD}
			do
				if [ "$i" == "$NUMBER" ]; then
					AVDNAME=${var}
				fi
				i=${i}+1
			done
			if [ -z "${AVDNAME}" ]; then
                tput setf 4
				echo -e "**********Wrong number!**********"
                tput setf 7
			fi
		done
	fi
fi

if [ ! -z "${AVDNAME}" ]; then
	emulator -avd ${AVDNAME} > /dev/null 2>&1 & 
    tput setf 2
	echo -e "\n*****Info: Begin to start ${AVDNAME} 'emulator -avd ${AVDNAME} &'*****\n"
    tput setf 7
	DEVICE=$(adb wait-for-device get-serialno)

	while [ "${READY}" != "y" -a "${READY}" != "Y" ]
	do
        tput setf 6
		read -p "Does ${AVDNAME} has started fully?(y/n): " READY
        tput setf 7
	done
fi
	
tput setf 2
echo -e "\n*****Info: ${DEVICE} was selected for installation*****\n"
echo -e "\n*****Info: Going to remove ${ZIPALIGNAPK##/*/}*****\n"
tput setf 7

if [ ! -z "$(adb -s ${DEVICE} shell pm list packages | grep ${PACKAGENAME})"  ]; then
declare -i DEVICEREADY=1
    while [ "${DEVICEREADY}" != 0 ]
    do
	    adb -s ${DEVICE} uninstall ${PACKAGENAME} > /dev/null 2>&1
	    DEVICEREADY=$?
	    if [ "${DEVICEREADY}" != 0 ]; then
		    sleep 1s
            tput setf 4
		    echo -e "*****Error: 'adb -s ${DEVICE} uninstall ${PACKAGENAME}' failed*****"
            tput setf 7
	    else
            tput setf 2
		    echo -e "\n*****Info: ${ZIPALIGNAPK##/*/} has been removed successfully! 'adb -s ${DEVICE} uninstall ${PACKAGENAME}'*****\n"
            tput setf 7
	    fi
    done
else
	echo -e "\n*****Info: ${ZIPALIGNAPK##/*/} is not installed*****\n"
fi


tput setf 2
echo -e "\n*****Info: Going to install ${ZIPALIGNAPK##/*/}*****\n"
tput setf 7
DEVICEREADY=1
while [ "${DEVICEREADY}" != 0 ]
do
	adb -s ${DEVICE} install ${ZIPALIGNAPK} > /dev/null 2>&1
	DEVICEREADY=$?
	if [ "${DEVICEREADY}" != 0 ]; then
		sleep 1s
        tput setf 4
		echo -e "*****Error: 'adb -s ${DEVICE} install ${ZIPALIGNAPK}' failed*****"
        tput setf 7
	else
        tput setf 2
		echo -e "\n*****Info: ${ZIPALIGNAPK##/*/} has been installed successfully. 'adb -s ${DEVICE} install ${ZIPALIGNAPK##/*/}'*****\n"
        tput setf 7
	fi 
done


OLDPIDLOGCAT=$(ps -ef | grep 'adb.*logcat' | grep -v 'grep' | awk '{print $2}' | tr '\n' ' ')
if [ -f "/tmp/logcat.txt" ]; then
	rm -rf /tmp/logcat.txt
fi
touch /tmp/logcat.txt
adb -s ${DEVICE} logcat -c
tput setf 2
echo -e "\n*****Info: Going to start ${ZIPALIGNAPK##/*/}*****\n"
tput setf 7
DEVICEREADY=1
while [ "${DEVICEREADY}" != 0 ]
do
    adb -s ${DEVICE} shell am start -n ${PACKAGENAME}/${PACKAGENAME}.${ACTIVITY} > /dev/null 2>&1
	DEVICEREADY=$?
	if [ "${DEVICEREADY}" != 0 ]; then
		sleep 1s
tput setf 4
		echo -e "*****Error: 'adb -s ${DEVICE} shell am start -n ${PACKAGENAME}/${PACKAGENAME}.${1}'*****"
tput setf 7
	else
tput setf 2
		echo -e "\n*****Info: Started the ${ZIPALIGNAPK##/*/} successfully*****\n"
tput setf 7
	fi
done

if [ "$1" == "logcat" ]; then
    if [ -z "$(ps -ef | grep '/monitor' | grep -v 'grep')" ]; then
        monitor > /dev/null & 
    else
        tput setf 6
        echo "*****Info: monitor has beed started alreadly*****"
        tput setf 7
    fi
fi

tput setf 2
echo "**************************************************************************"
echo -e "***************************Logcat information*****************************\n"
tput setf 4

printf "\n"
adb -s ${DEVICE} logcat -d > /tmp/logcat_${ACTIVITY}.txt
tput setf 4
grep '^E/.*'${LOWEREDSCRIPTNAME} /tmp/logcat_${ACTIVITY}.txt
tput setf 6
grep "${ACTIVITY}" /tmp/logcat_${ACTIVITY}.txt
tput setf 2
echo -e "\n**************************************************************************"
echo "**************************************************************************"
tput setf 7
