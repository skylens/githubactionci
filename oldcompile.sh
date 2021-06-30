#!/bin/bash

brew reinstall autoconf automake cmake c-ares libev git
mkdir -pv ~/shadowsocks-libev-macOS/{libsodium,mbedtls,shadowsocks-libev}
cd ~/
wget https://ftp.skylens.co/mbedtls-2.16.6.tgz
wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz
wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz
echo "libsodium install"
tar -xvf ~/libsodium-1.0.18.tar.gz
pushd libsodium-1.0.18
./configure --prefix=/Users/runner/shadowsocks-libev-macOS/libsodium && make
sudo make install
popd
echo "mbedtls install"
tar -xvf ~/mbedtls-2.16.6.tgz
pushd mbedtls-2.16.6
make SHARED=1
sudo make install
popd
echo "shadowsocks install"
tar -xvf ~/shadowsocks-libev-3.3.5.tar.gz
pushd shadowsocks-libev-3.3.5
./configure --prefix=/Users/runner/shadowsocks-libev-macOS/shadowsocks-libev --disable-documentation \
--with-mbedtls=/Users/runner/shadowsocks-libev-macOS/mbedtls \
--with-sodium=/Users/runner/shadowsocks-libev-macOS/libsodium \
&& make
cd build && cmake ../ && make
sudo make install
popd
cp -r ~/shadowsocks-libev-3.3.5 ~/shadowsocks-libev-macOS/
cd ~/
tar -zcf shadowsocks-libev-macOS.tgz shadowsocks-libev-macOS
7z a shadowsocks-libev-macOS.7z shadowsocks-libev-macOS