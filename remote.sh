#!/bin/bash
scp -r -P 2222 . vm@127.0.0.2:~/trolldropapp
ssh vm@127.0.0.2 -p 2222 -t 'cd ~/trolldropapp; rm -rf packages; source ~/.profile; PATH="/usr/local/bin/:$PATH"; make package; exit'
scp -P 2222 vm@127.0.0.2:~/trolldropapp/packages/* /tmp/trolldrop.deb
ssh vm@127.0.0.2 -p 2222 -t 'rm -rf ~/trolldropapp; exit'
scp -P 2222 /tmp/trolldrop.deb root@10.0.0.167:/tmp/trolldrop.deb
ssh -p 2222 root@10.0.0.167 -t 'dpkg -i /tmp/trolldrop.deb; exit'