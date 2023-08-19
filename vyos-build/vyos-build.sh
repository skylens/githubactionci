#!/bin/bash
set -ex
docker pull vyos/vyos-build:equuleus
git clone -b equuleus --single-branch https://github.com/vyos/vyos-build
cd vyos-build
wget 'https://drive.skylens.cc/api/raw/?path=/software/vmware/VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle' -O VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle
# docker build -t vyos/vyos-build:equuleus docker

# alias vybld_equuleus='docker pull vyos/vyos-build:equuleus && docker run --rm -it \
#     -v "$(pwd)":/vyos \
#     -v "$HOME/.gitconfig":/etc/gitconfig \
#     -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
#     -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
#     -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
#     -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
#     vyos/vyos-build:equuleus bash'

docker run --rm -it --privileged -v $(pwd):/vyos -w /vyos vyos/vyos-build:equuleus bash
sudo apt update
sudo apt install -y wget libncurses5 tree
sudo ln -s /lib/x86_64-linux-gnu/libncursesw.so.6 /lib/x86_64-linux-gnu/libncursesw.so.5
chmod +x VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle
sudo ./VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle
./configure --architecture amd64 --build-by "skylens116@outlook.com"
# make iso
# install ovftools && gen privatekey sign ova
openssl req -x509 -nodes -sha256 -days 3650 -newkey rsa:1024 -keyout privatekey.pem -out privatekey.pem -subj "/C=US/ST=California/L=Palo Alto/O=VMware/CN=vyos"
make vmware
tree
