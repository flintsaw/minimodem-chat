# Minimodem chat 

 A simple chat program written as a bash script. to make easy 
 interactive use of minimodem along with providing 
 encryption using OpenSSL.

 To use this script a compatible audio software package for 
 minimodem is needed, (Pulseaudio is recommended).
 
 This software only streams text for modulation/demoulation 
 of audio by minimodem. For transmission an external transceiver 
 would be needed to be connected to the headphone and microphone 
 audio jacks of the PC/laptop/SoC.

 Temporary file used by minimodem-chat will be placed in a 
 folder called mmc-tmp in the running directory to help 
 ease cleanup.

## Dependancies
 The dependancies will be checked if you select to when 
 prompted, after which you will not be bothered by the
 prompt after the checks are made once on your system.
 to view it again delete /var/log/mmc-int


## comm-config
 This file sets up screen to provided the interactive 
 terminal sessions. 

## chat.conf
 The options avalaible to set in chat.conf are.

```
 encrypt |set to 'sym' for symmetric encryption with passphrase 
          set to 'key' for asymmetric encryption with public/private keys
          set to 'off' to disable encryption 


 pass    |This is required if you set the encrypt variable
          if using sym encryption set a 'passphrase'
          if using key encryption set a key location '/Desktop/public.pem'
```

## KEY GENERATION
 
 The proccess in OpenSSL to generate keys:
```
 openssl req -x509 -nodes -newkey rsa:2048 -keyout private.pem -out public.pem
```
 Note that the above command creates a private key without a password.
 Follow the prompts to generate it, but know what information you enter 
 can leak information about you. 
 

## IMPORTANT

 Asymmetric encryption is done with s/mime set. Be sure when creating  
 a encrypted file by pasting data to a file it's name corrisponds to the 
 encryption method used. 

    test.enc for symmetric crypto
    
    test.eml for s/mime asymmetric crypto 

 Also when pasting encrypted content be sure not to include trailing 
 whitespaces as these will prevent the .enc/.eml file from being decrypted. 
 
## DECRYPTION

 OpenSSL symmetric encryption: 
 You must know the encryption type as it's an option that needs to be set
```
 openssl enc -aes-256-cbc -d -a -in test.enc -out test
``` 

 OpenSSL asymmetric encryption (public key):
```
 openssl smime -decrypt -in test.eml -inkey privatekey.pem -out test
```
 

 enjoy...
 
 nightowlconsulting.com
