while true
do
procrank | grep mediacenter | awk '{print $5}'
pid=`ps | grep mediacenter | awk '{print $2}'`
ls -l /proc/$pid/fd > /data/fd.tmp
total=`wc -l /data/fd.tmp`
anon=`grep 'anon_inode' /data/fd.tmp | wc -l`
ashmem=`grep '/dev/ashmem' /data/fd.tmp | wc -l`
pipe=`grep 'pipe' /data/fd.tmp | wc -l`
socket=`grep 'socket' /data/fd.tmp | wc -l`
echo "total:$total    anon_inode:$anon    /dev/ashmem:$ashmem    pipe:$pipe    socket:$socket"
echo ""
sleep 1
done
