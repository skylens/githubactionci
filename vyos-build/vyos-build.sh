#!/bin/bash
set -ex
docker pull vyos/vyos-build:equuleus
git clone -b equuleus --single-branch https://github.com/vyos/vyos-build
cp make.sh vyos-build
cp template.ovf vyos-build/scripts/
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

docker run --rm --privileged -v $(pwd):/vyos -w /vyos vyos/vyos-build:equuleus sh -c "chmod +x /vyos/make.sh && /vyos/make.sh"

