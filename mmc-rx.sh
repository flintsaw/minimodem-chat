#!/bin/bash
#
# Simple bash program to create a basic
# chat interface for use with minimodem
# recieve
#---------------------------------------------------------------------

while true; do
printf "*************************************"
printf "\nUsing screen so use it's \nhot keys for navigation\n\n"
printf "*************************************\n\n"
sleep 1
minimodem -q --rx -8 30 | tee -a tmp/rx-log
done
exit
