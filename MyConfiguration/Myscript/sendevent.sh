logcat -c
sendevent /dev/input/event4 1 $1 1
sendevent /dev/input/event4 0 0 0
sendevent /dev/input/event4 1 $1 0
sendevent /dev/input/event4 0 0 0
logcat
