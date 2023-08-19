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