#!/bin/bash
set -ex
sudo apt install -y git python3-pip
sudo pip3 install j2cli
sudo modprobe overlay
git clone https://github.com/Azure/sonic-buildimage.git
cd sonic-buildimage
make init
make configure PLATFORM=vs
make SONIC_BUILD_JOBS=4 all
