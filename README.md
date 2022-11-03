# Minimodem chat - Forked from eyedeekay. Thanks!

 A simple chat program written as a bash script to make easy, 
 interactive use of minimodem along with providing
 encryption using OpenSSL.

 This script requires a compatible audio software package.
 Pulseaudio is recommended.
 
 This software only streams text for modulation/demoulation 
 of audio by minimodem. An external transceiver (with VOX or
 a PTT circuit) connected to the headphone and microphone
 audio jacks of the PC/laptop/SoC is required. 

 Temporary files used by minimodem-chat will be placed in a 
 folder called mmc-tmp in the running directory to help 
 ease cleanup.

## Dependencies
 You will be prompted to check the dependencies at first startup.
 You will not be bothered by the prompt after the checks are
 made once on your system.
 To view it again delete /var/log/mmc-int

## comm-config
 This file sets up screen to provided the interactive 
 terminal sessions. 

## chat.conf
 The options avalaible to set in chat.conf are.

```
 encrypt
 pass
 mark
 space
 card
```
 
 enjoy...
 
 nightowlconsulting.com
