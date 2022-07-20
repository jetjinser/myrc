#!/bin/sh
PID=`pidof swaybg`
swaybg -i $(find /home/cirno99/backup/wallpapers/pixiv/2020/. -type f | shuf -n1) -m fill &
sleep 1
kill $PID