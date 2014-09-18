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
minimodem -q --rx -8 30 | tee -a tmp/rx-log
done
exit
