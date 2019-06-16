#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[1;33m'

wget https://raw.githubusercontent.com/thanhhvnqb/Colab/master/myutils.py -O myutils.py

apt-get install -y -qq software-properties-common module-init-tools
add-apt-repository -y ppa:alessandro-strada/ppa 2>&1 > /dev/null
apt-get update -qq 2>&1 > /dev/null
apt-get -y install -qq google-drive-ocamlfuse fuse
echo -e $TEXT_YELLOW
echo 'APT finished installing drive connector..'
echo -e $TEXT_RESET
