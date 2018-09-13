#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[1;33m'

wget https://raw.githubusercontent.com/thanhhvnqb/Mxnet_colab/master/mxnet_utils.py -O mxnet_utils.py
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
echo -e $TEXT_YELLOW
echo 'WEBGET finished..'
echo -e $TEXT_RESET

apt-get install -y -qq software-properties-common python-software-properties module-init-tools
add-apt-repository -y ppa:alessandro-strada/ppa 2>&1 > /dev/null
apt-get update -qq 2>&1 > /dev/null
apt-get -y install -qq google-drive-ocamlfuse fuse
echo -e $TEXT_YELLOW
echo 'APT finished installing drive connector..'
echo -e $TEXT_RESET


apt install libnvrtc8.0
pip install mxnet-cu80mkl
pip install gluoncv
pip install mxboard
echo -e $TEXT_YELLOW
echo 'PIP finished installing Mxnet..'
echo -e $TEXT_RESET
