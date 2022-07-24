#!/bin/sh

PID=`pidof swaybg`
swaybg -i $(find /home/jinser/wallpapers/. -type f | shuf -n1) -m fill &
sleep 1
kill $PID
