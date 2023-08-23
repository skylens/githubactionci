#!/bin/bash
set -ex

docker pull vyos/vyos-build:equuleus
git clone -b equuleus --single-branch https://github.com/vyos/vyos-build
cp make.sh vyos-build
wget 'https://drive.skylens.cc/api/raw/?path=/software/vmware/VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle' -O vyos-build/VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle

sudo apt update
sudo apt install -y wget libncurses5 tree curl ansible python3
sudo ln -s /lib/x86_64-linux-gnu/libncursesw.so.6 /lib/x86_64-linux-gnu/libncursesw.so.5
chmod +x vyos-build/VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle
sudo ./vyos-build/VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle --console --required --eulas-agreed

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

mkdir build
cp vyos-build/build/vyos-1.3.3-amd64.iso build

# vmware ova
git clone https://github.com/skylens/vyos-vm-images
cp build/vyos-1.3.3-amd64.iso vyos-vm-images
cd vyos-vm-images
openssl req -x509 -nodes -sha256 -days 3650 -newkey rsa:1024 -keyout privatekey.pem -out privatekey.pem -subj "/C=US/ST=California/L=Palo Alto/O=VMware/CN=vyos"
sudo ansible-playbook vmware.yml -e vyos_vmware_private_key_path=privatekey.pem -e cloud_init=false -e ovf_template=simple -e iso_url=https://ftp.skylens.cc/vyos/vyos-1.3.3-amd64.iso -e iso_local=$PWD/vyos-1.3.3-amd64.iso -e guest_agent=vmware -e parttable_type=hybrid -e keep_user=true -e enable_dhcp=true -e enable_ssh=true
sudo cp $PWD/vyos-1.3.3-vmware.ova ../build
cd ../
sudo chown -R runner:runner build
tree build