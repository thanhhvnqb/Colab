#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[1;33m'

wget https://github.com/thanhhvnqb/Mxnet_colab/blob/master/mxnet_utils.py
https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda-repo-ubuntu1710-9-2-local_9.2.148-1_amd64
echo -e $TEXT_YELLOW
echo 'WEBGET finished..'
echo -e $TEXT_RESET

dpkg -i cuda-repo-ubuntu1710-9-2-local_9.2.148-1_amd64.deb
echo -e $TEXT_YELLOW
echo 'DPKG finished..'
echo -e $TEXT_RESET

apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1710/x86_64/7fa2af80.pub
echo -e $TEXT_YELLOW
echo 'APT added key..'
echo -e $TEXT_RESET

apt-get update
echo -e $TEXT_YELLOW
echo 'APT update finished..'
echo -e $TEXT_RESET

apt-get install cuda-9-2
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
pip install mxnet-cu80
pip install gluoncv
pip install mxboard
echo -e $TEXT_YELLOW
echo 'PIP finished installing Mxnet..'
echo -e $TEXT_RESET
