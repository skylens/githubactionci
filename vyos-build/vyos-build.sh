#!/bin/bash
set -ex
docker pull vyos/vyos-build:equuleus
git clone -b equuleus --single-branch https://github.com/vyos/vyos-build
cp make.sh vyos-build
wget 'https://drive.skylens.cc/api/raw/?path=/software/vmware/VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle' -O vyos-build/VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle

sudo apt update
sudo apt install -y wget libncurses5 tree curl
sudo ln -s /lib/x86_64-linux-gnu/libncursesw.so.6 /lib/x86_64-linux-gnu/libncursesw.so.5
chmod +x VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle
sudo ./VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle --console --required --eulas-agreed

# docker build -t vyos/vyos-build:equuleus docker

# alias vybld_equuleus='docker pull vyos/vyos-build:equuleus && docker run --rm -it \
#     -v "$(pwd)":/vyos \
#     -v "$HOME/.gitconfig":/etc/gitconfig \
#     -v "$HOME/.bash_aliases":/home/vyos_bld/.bash_aliases \
#     -v "$HOME/.bashrc":/home/vyos_bld/.bashrc \
#     -w /vyos --privileged --sysctl net.ipv6.conf.lo.disable_ipv6=0 \
#     -e GOSU_UID=$(id -u) -e GOSU_GID=$(id -g) \
#     vyos/vyos-build:equuleus bash'

docker run --rm --privileged -v $(pwd)/vyos-build:/vyos -w /vyos vyos/vyos-build:equuleus sh -c "chmod +x /vyos/make.sh && /vyos/make.sh"

# vmware ova
git clone https://github.com/vyos/vyos-vm-images
sed -i vyos-vm-images/roles/vmware/vars/main.yml

sed -i 's#/tmp#'"$(pwd)/build/"'#g' roles/vmware/vars/main.yml

sed 's#/tmp#'"$HOME/build"'#g' roles/vmware/vars/main.yml