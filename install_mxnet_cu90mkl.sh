#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[1;33m'

wget https://raw.githubusercontent.com/thanhhvnqb/Mxnet_colab/master/mxnet_utils.py -O mxnet_utils.py
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
echo -e $TEXT_YELLOW
echo 'WEBGET finished..'
echo -e $TEXT_RESET

dpkg -i cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
echo -e $TEXT_YELLOW
echo 'DPKG finished..'
echo -e $TEXT_RESET

apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
echo -e $TEXT_YELLOW
echo 'APT added key..'
echo -e $TEXT_RESET

apt-get update
echo -e $TEXT_YELLOW
echo 'APT update finished..'
echo -e $TEXT_RESET

echo -e $TEXT_YELLOW
echo 'APT start installing cuda..'
apt-get install cuda > /dev/null
echo -e $TEXT_YELLOW
echo 'APT finished installing cuda..'

echo 'The CUDA version is: '
cat /usr/local/cuda/version.txt
echo -e $TEXT_RESET

apt-get install -y -qq software-properties-common python-software-properties module-init-tools
add-apt-repository -y ppa:alessandro-strada/ppa 2>&1 > /dev/null
apt-get update -qq 2>&1 > /dev/null
apt-get -y install -qq google-drive-ocamlfuse fuse
echo -e $TEXT_YELLOW
echo 'APT finished installing drive connector..'
echo -e $TEXT_RESET


apt install libnvrtc8.0
pip install mxnet-cu90mkl==1.2.1
pip install gluoncv
pip install mxboard
echo -e $TEXT_YELLOW
echo 'PIP finished installing Mxnet..'
echo -e $TEXT_RESET
