su
mount -o remount rw /system
rm -f /data/bootchart-start
rm -rf /data/bootchart
echo 120 > /data/bootchart-start
mkdir /data/bootchart
