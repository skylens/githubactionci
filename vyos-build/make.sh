sudo apt update
sudo apt install -y wget libncurses5 tree curl
sudo ln -s /lib/x86_64-linux-gnu/libncursesw.so.6 /lib/x86_64-linux-gnu/libncursesw.so.5
chmod +x VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle
sudo ./VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle --console --required --eulas-agreed
mkdir key
openssl req -x509 -nodes -sha256 -days 3650 -newkey rsa:1024 -keyout privatekey.pem -out privatekey.pem -subj "/C=US/ST=California/L=Palo Alto/O=VMware/CN=vyos"
cp privatekey.pem key
sudo ./configure --architecture amd64 --build-by "skylens116@outlook.com"
# make iso
# install ovftools && gen privatekey sign ova
sudo make vmware
sudo curl -X 'PUT' -T build/vyos_vmware_image-signed.ova https://ftp.skylens.cc/uploads/ -vvv
