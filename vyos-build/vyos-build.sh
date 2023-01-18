#!/bin/bash
set -ex
docker pull vyos/vyos-build:equuleus
git clone -b equuleus --single-branch https://github.com/vyos/vyos-build
cd vyos-build
docker build -t vyos/vyos-build:equuleus docker

# alias vybld_equuleus='docker pull vyos/vyos-build:equuleus && docker run --rm -it \
#     -v "$(pwd)":/vyos \
#     -v "$HOME/.gitconfig":/etc/gitconfig \
#     -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
#     -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
#     -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
#     -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
#     vyos/vyos-build:equuleus bash'

cd vyos-build
sudo su
./configure --architecture amd64 --build-by "skylens116@outlook.com"
make iso
# install ovftools
make vmware

cd build