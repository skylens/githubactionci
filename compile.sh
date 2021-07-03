#!/bin/bash

brew install automake gsed upx

# wget https://sourceforge.net/projects/ijbswa/files/Sources/3.0.32%20%28stable%29/privoxy-3.0.32-stable-src.tar.gz
# tar zxf privoxy-3.0.32-stable-src.tar.gz
# cd privoxy-3.0.32-stable-src
# git clone https://www.privoxy.org/git/privoxy.git
# cd privoxy
# autoheader
# autoconf
# ./configure --prefix=/Users/runner/project/dists/privoxy 
# make

ver=2.16.6
wget --no-check-certificate https://tls.mbed.org/download/mbedtls-$ver-gpl.tgz
tar zxf mbedtls-$ver-gpl.tgz
cd mbedtls-$ver
# cmake -DUSE_SHARED_MBEDTLS_LIBRARY=On -DPython3_EXECUTABLE=/usr/bin/python3
gsed -i "s/DESTDIR=\/usr\/local/DESTDIR=\/Users\/runner\/project\/dists\/mbedtls/g" Makefile
# make SHARED=0 && make install
make lib && make install
cp /Users/runner/project/dists/mbedtls/lib/libmbedcrypto.dylib /Users/runner/project/dists/shadowsocks-libev/bin/
cd ..

ver=8.45
wget https://ftp.pcre.org/pub/pcre/pcre-$ver.tar.gz
tar zxf pcre-$ver.tar.gz
cd pcre-$ver
./configure --prefix=/Users/runner/project/dists/pcre --disable-shared --enable-utf8 --enable-unicode-properties
make && make install
cd ..

ver=1.0.18
wget --no-check-certificate https://download.libsodium.org/libsodium/releases/libsodium-$ver.tar.gz
tar zxf libsodium-$ver.tar.gz
cd libsodium-$ver
./configure --prefix=/Users/runner/project/dists/libsodium --disable-ssp --disable-shared
make && make install
cd ..

wget http://dist.schmorp.de/libev/libev-4.33.tar.gz 
tar zxf libev-4.33.tar.gz
cd libev-4.33
./configure --prefix=/Users/runner/project/dists/libev --disable-shared
make && make install
cd ..

ver=1.17.1
wget https://c-ares.haxx.se/download/c-ares-$ver.tar.gz
tar zxf c-ares-$ver.tar.gz
cd c-ares-$ver
./configure --prefix=/Users/runner/project/dists/cares --disable-shared
make && make install 
cd ..

git clone https://github.com/shadowsocks/shadowsocks-libev
cd shadowsocks-libev
git submodule init && git submodule update
./autogen.sh
./configure --prefix=/Users/runner/project/dists/shadowsocks-libev \
--disable-documentation \
--with-mbedtls=/Users/runner/project/dists/mbedtls \
--with-pcre=/Users/runner/project/dists/pcre \
--with-cares=/Users/runner/project/dists/cares \
--with-sodium=/Users/runner/project/dists/libsodium \
--with-ev=/Users/runner/project/dists/libev
make && make install
cd ..

git clone https://github.com/shadowsocks/simple-obfs
cd simple-obfs
git submodule init && git submodule update
./autogen.sh
./configure --prefix=/Users/runner/project/dists/shadowsocks-libev --disable-documentation
make && make install
cd ..

git clone https://github.com/shadowsocks/v2ray-plugin.git
cd v2ray-plugin
env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --tags) -s -w -buildid=" -o v2ray-plugin-darwin
cp v2ray-plugin-darwin /Users/runner/project/dists/shadowsocks-libev/bin/v2ray-plugin
cd ..

git clone https://github.com/cbeuw/Cloak.git
cd Cloak
env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --tags) -s -w -buildid=" -o ck-client-darwin ./cmd/ck-client
cp ck-client-darwin /Users/runner/project/dists/shadowsocks-libev/bin/ck-client
cd ..

# upx
cd /Users/runner/project/dists/shadowsocks-libev/bin/
upx ss-local
upx obfs-local
upx v2ray-plugin
upx ck-client

cd /Users/runner/project/

gtar zcvf ~/shadowsocks-libev-macOS-`date +%Y-%m-%d-%s`.tgz dists/