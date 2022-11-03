#!/bin/bash
#
# Simple bash program to create a basic
# chat interface for use with minimodem
# transmission. Forked from eyedeekay.
#---------------------------------------------------------------------


tstamp() {
 date +"%F"" ""%H":"%M"
}

wrap_up() {
 RX=$(pidof -x "mmc-rx.sh")
 TX=$(pidof -x "mmc-tx.sh")
 kill -9 $RX
 kill -9 $TX
 exit
}

trap wrap_up INT TERM

cfgpath="$( cd "$(dirname "$0")" ; pwd -P )"
if [[ ! -e $cfgpath/chat.conf ]]; then
     printf "The chat.conf file was not detected on $(tstamp), exiting..."
     exit
fi

source $cfgpath/chat.conf

printf "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n"
printf "\n     Minimodem Chat"
printf "\n"
printf "\n\n To configure encryption\n edit chat.conf\n"
printf "\n*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n"
while true
do

    if [ ! -d tmp/ ];then
    mkdir tmp
    fi
    if [ ! -e tmp/tx-log ]; then
    touch tmp/tx-log
    fi
    if [ ! -e tmp/tx-main-log ]; then
    touch tmp/tx-main-log
    fi
    cat tmp/tx-main-log
    printf "*****************************************"
    printf "\nType message then press enter TWICE. To quit hit ctrl-c\n"
    printf "*****************************************"
    done
    printf "========================================="
    printf "\nInput message:\n\n"
    rfmsg=$(sed '/^$/q')
    printf "\nTransmitting msg...\n"
    cat > tmp/tx-log <<- EOL

	$(tstamp)
	$rfmsg

       ccrypt -e tmp/tx-log -K $pass
       cat tmp/tx-log.enc | minimodem --tx 30 -M $mark -S $space --alsa=plughw:$card --float-samples

       clear
       printf "\n---------\n" >> tmp/tx-main-log
       cat tmp/tx-log.enc >> tmp/tx-main-log
       printf "\n---------\n\n" >> tmp/tx-main-log
       rm tmp/tx-log.enc    
done
exit
