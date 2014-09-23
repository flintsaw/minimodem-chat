#!/bin/bash
#
#
# Simple bash program to create a basic
# chat interface for use with minimodem
# launcher
#---------------------------------------------------------------------

chk_usr() {
   if [ "$(whoami)" != "$1" ]; then
       printf "\nyou need to be root, try sudo\nexiting....\n\n"
       exit 1
   fi
}

chk_tubes() {
  printf "\nChecking your tubes..."
  if ! ping -c 1 google.com > /dev/null 2>&1  ; then
      if ! ping -c 1 yahoo.com > /dev/null 2>&1  ; then
         if ! ping -c 1 bing.com > /dev/null 2>&1 ; then
             clear
             printf "\n\ndo you have an internet connection???\n\n"
             exit 1
         fi
      fi
  fi
  printf "\n\ntubes working....\n\n"

}

get_aptpkg() {
   printf "\nfetching $1 from apt\n"
   if ! apt-get -y install $1; then
       printf "\n\nAPT failed to install "$1", are your repos working?\nexiting...\n\n"
       exit 1
   fi
}

# func requires get_aptpkg func/ it test is bin exist if not tries to get it.
test_bin() {
   if ! hash $1 >/dev/null 2>&1 ; then
      get_aptpkg $1
   fi
}



if [ ! -e /var/log/mmc-int ]; then

  printf "\nIt seems that you have not run minimodem-chat before"
  printf "\nwould you like to check if you missing any dependancies?"
  printf "\nnote pulseaudio will not be installed by these checks"
  printf "\nas it is installed by default on most Ubuntu based distros"
  printf "\n(y/n)?\n"
  while true; do
      printf "\n"
      read ansr
      case $ansr in
          [nN] ) break ;;
          [Yy] ) printf "\nchecking...." :
                 chk_usr root
                 chk_tubes
                 apt-get update
                 test_bin tee
                 test_bin screen
                 test_bin minimodem
                 test_bin openssl
                 printf "\nit seems you are good to go.\n\n"
                 date > /var/log/mmc-int
                 printf "minimodem-chat by xor-function\n\n" >> /var/log/mmc-int
                 printf "\nchecks are done run again as a regular user.\n"
                 exit
                 ;;
             * ) printf "\nNot a valid entry \nPlease answer y or n";;
       esac
  done
fi

screen -c comm-config
if [ ! $? -eq 0 ]; then
 trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
fi

exit

