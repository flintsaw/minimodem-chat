#!/bin/bash
#
# Simple bash program to create a basic
# chat interface for use with minimodem
# transmission
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
     printf "the chat.conf file was not detected on $(tstamp), exiting..."
     exit
fi

source $cfgpath/chat.conf

printf "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n"
printf "\n     Minimodem Chat"
printf "\n"
printf "\n\n To configure encryption\n edit mm-tx.sh\n"
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
    while true; do
      case $encrypt in
          [oO][Ff][Ff] ) printf "\nENCRYPTION IS OFF\n"; break ;;
          [sS][yY][mM] ) printf "\nSet to symmetric encryption\n" ; break ;;
          [kK][Ee][yY] ) printf "\nSet to public key encryption\n" ; break ;;
                     * ) printf "\nEncryption variable options not set correctly \n\nENCRYPTION IS OFF!\n" :
                           unset encrypt
                           encrypt=off
                           break
                           ;;
      esac
    done
    printf "========================================="
    printf "\nInput message:\n\n"
    rfmsg=$(sed '/^$/q')
    printf "\ntransmitting msg...\n"
    cat > tmp/tx-log <<- EOL

	$(tstamp)
	$rfmsg

	EOL
    if [ $encrypt == "off" ]; then
       cat tmp/tx-log | minimodem --tx -8 30
       cat tmp/tx-log >> tmp/tx-main-log
    fi

    if [ $encrypt == "sym" ]; then
       openssl aes-256-cbc -a -salt -in tmp/tx-log -out tmp/tx-log.enc -pass pass:$pass
       echo "BOF BOF" | minimodem --tx 30 -M $mark -S $space --alsa=$card --float-samples
       cat tmp/tx-log.enc | minimodem --tx 30 -M $mark -S $space --alsa=$card --float-samples
       echo "EOF EOF" | minimodem --tx 30 -M $mark -S $space --alsa=$card --float-samples
       clear
       printf "\n---------\n" >> tmp/tx-main-log
       cat tmp/tx-log.enc >> tmp/tx-main-log
       printf "\n---------\n\n" >> tmp/tx-main-log
       rm tmp/tx-log.enc
    fi
    
done

exit
