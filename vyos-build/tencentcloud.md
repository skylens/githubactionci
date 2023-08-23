# tencent cloud

```bash
docker run --rm --privileged -v $(pwd):/vyos -w /vyos -it vyos/vyos-build:equuleus bash
```


```bash
sudo apt update
sudo apt install -y wget libncurses5 tree curl
sudo ln -s /lib/x86_64-linux-gnu/libncursesw.so.6 /lib/x86_64-linux-gnu/libncursesw.so.5
chmod +x VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle
sudo ./VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle --console --required --eulas-agreed
mkdir key
openssl req -x509 -nodes -sha256 -days 3650 -newkey rsa:1024 -keyout privatekey.pem -out privatekey.pem -subj "/C=US/ST=California/L=Palo Alto/O=VMware/CN=vyos"
cp privatekey.pem key
./configure --architecture amd64 --build-by "skylens116@outlook.com" \
--version 1.3.3 --build-type release \
--debian-mirror http://mirrors.tencentyun.com/debian/ \
--debian-security-mirror http://mirrors.tencentyun.com/debian-security/ \
--pbuilder-debian-mirror http://mirrors.tencentyun.com/debian/
make iso
```

 lb config noauto --architectures amd64 --bootappend-live boot=live components hostname=vyos username=live nopersistence noautologin nonetworking union=overlay console=ttyS0,115200 console=tty0 net.ifnames=0 biosdevname=0 --bootappend-live-failsafe live components memtest noapic noapm nodma nomce nolapic nomodeset nosmp nosplash vga=normal console=ttyS0,115200 console=tty0 net.ifnames=0 biosdevname=0 --linux-flavours amd64-vyos --linux-packages linux-image-5.4.243 --bootloader syslinux,grub-efi --binary-images iso-hybrid --checksums sha256 md5 --debian-installer false --distribution buster --iso-application VyOS --iso-publisher skylens116@outlook.com --iso-volume VyOS --debootstrap-options --variant=minbase --exclude=isc-dhcp-client,isc-dhcp-common,ifupdown --include=apt-utils,ca-certificates,gnupg2 --mirror-bootstrap http://mirrors.tencentyun.com/debian/ --mirror-chroot http://mirrors.tencentyun.com/debian/ --mirror-chroot-security http://mirrors.tencentyun.com/debian-security/ --mirror-binary http://mirrors.tencentyun.com/debian/ --mirror-binary-security http://mirrors.tencentyun.com/debian-security/ --archive-areas main contrib non-free --firmware-chroot false --firmware-binary false --updates true --security true --backports true --apt-recommends false --apt-options --yes -oAPT::Default-Release=equuleus -oAPT::Get::allow-downgrades=true --apt-indices false


vyos-build/vyos-build/build/vyos_vmware_image-signed.ova

vyos-build/vyos-build/build/vyos-1.3.3-amd64.iso


group_vars/all.yml

sed -i 's#/tmp#'"$(pwd)/build/"'#g' roles/vmware/vars/main.yml

sed 's#/tmp#'"$HOME/build"'#g' roles/vmware/vars/main.yml


ansible-playbook vmware.yml -e vyos_vmware_private_key_path=privatekey.pem -e cloud_init=false -e ovf_template=simple -e iso_local=vyos-1.3.3-amd64.iso -e guest_agent=vmware -e parttable_type=hybrid -e keep_user=true -e enable_dhcp=true -e enable_ssh=true

ansible-playbook vmware.yml -e vyos_vmware_private_key_path=privatekey.pem -e cloud_init=false -e ovf_template=simple -e vyos_version=1.3.3 -e iso_local=/home/ubuntu/vyos-vm-images/vyos-1.3.3-amd64.iso -e guest_agent=vmware -e parttable_type=hybrid -e keep_user=true -e enable_dhcp=true -e enable_ssh=true

ansible-playbook vmware.yml -e vyos_vmware_private_key_path=privatekey.pem -e cloud_init=false -e ovf_template=simple -e iso_local=vyos-1.3.3-amd64.iso -e guest_agent=vmware -e keep_user=true -e enable_dhcp=true -e enable_ssh=true