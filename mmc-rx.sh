#!/bin/bash
#
# Simple bash program to create a basic
# chat interface for use with minimodem
# recieve
#---------------------------------------------------------------------

while true; do
printf "*************************************"
printf "\nlistening for data.\n"
printf "*************************************\n\n"
sleep 1

    if [ $encrypt == "off" ]; then
       minimodem -q --rx 30 -M $mark -S $space -c 2 --alsa=plughw:$card | tee -a tmp/rx-log
       cat tmp/rx-log >> tmp/rx-main-log
    fi

    if [ $encrypt == "sym" ]; then
       minimodem -q --rx 30 -M $mark -S $space -c 2 --alsa=plughw:$card | tee -a tmp/rx-log.cpt
       ccrypt -d tmp/rx-log.cpt -K $pass
       cat tmp/rx-log >> tmp/rx-main-log
    fi
    
done
exit
