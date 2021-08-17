#!/bin/bash

PREFIX=/home/runner/project/dists/new

ver=1.2.11
# wget https://zlib.net/zlib-$ver.tar.gz
tar -xvf zlib-$ver.tar.gz
cd zlib-$ver
./configure --prefix=$PREFIX --static
make && make install
cd ..

ver=8.45
# wget https://ftp.pcre.org/pub/pcre/pcre-$ver.tar.gz
tar zxf pcre-$ver.tar.gz
cd pcre-$ver
./configure --prefix=$PREFIX --disable-shared --enable-utf8 --enable-unicode-properties
make && make install
cd ..

ver=2.16.6
# wget --no-check-certificate https://tls.mbed.org/download/mbedtls-$ver-gpl.tgz
tar zxf mbedtls-$ver-gpl.tgz
cd mbedtls-$ver
LDFLAGS=-static make DESTDIR=$PREFIX install
# make lib && make install
cd ..

ver=1.0.18
# wget --no-check-certificate https://download.libsodium.org/libsodium/releases/libsodium-$ver.tar.gz
tar zxf libsodium-$ver.tar.gz
cd libsodium-$ver
./configure --prefix=$PREFIX --disable-shared
make && make install
cd ..

ver=4.33
# wget http://dist.schmorp.de/libev/libev-$ver.tar.gz 
tar zxf libev-$ver.tar.gz
cd libev-$ver
./configure --prefix=$PREFIX --disable-shared
make && make install
cd ..

ver=1.17.1
# wget https://c-ares.haxx.se/download/c-ares-$ver.tar.gz
tar zxf c-ares-$ver.tar.gz
cd c-ares-$ver
./configure --prefix=$PREFIX --disable-shared
make && make install 
cd ..

# git clone https://github.com/shadowsocks/shadowsocks-libev
cd shadowsocks-libev
# git submodule init && git submodule update
./autogen.sh
LIBS="-lpthread -lm" LDFLAGS="-Wl,-static -static -static-libgcc -L$PREFIX/lib" CFLAGS="-I$PREFIX/include" \
./configure --prefix=$PREFIX \
--disable-documentation \
--with-mbedtls=/home/runner/project/dists/mbedtls \
--with-pcre=/home/runner/project/dists/pcre \
--with-cares=/home/runner/project/dists/cares \
--with-sodium=/home/runner/project/dists/libsodium \
--with-ev=/home/runner/project/dists/libev
make && make install
cd ..

# git clone https://github.com/shadowsocks/simple-obfs.git
# cd simple-obfs
# git submodule update --init --recursive
# ./autogen.sh
# ./configure --prefix=/home/runner/project/dists/shadowsocks-libev \
# --disable-documentation \
# --with-ev=/home/runner/project/dists/libev
# make
# make install
# cd ..

# git clone https://github.com/shadowsocks/v2ray-plugin
# cd v2ray-plugin
# env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
# go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o v2ray-plugin-darwin
# cp v2ray-plugin-darwin /home/runner/project/dists/shadowsocks-libev/bin/v2ray-plugin
# cd ..

# git clone https://github.com/cbeuw/Cloak
# cd Cloak
# env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
# go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o ck-client-darwin ./cmd/ck-client
# cp ck-client-darwin /home/runner/project/dists/shadowsocks-libev/bin/ck-client
# cd ..

# mkdir -p build/releases
# cp /home/runner/project/dists/shadowsocks-libev/bin/ss-* build/releases
# cp /home/runner/project/dists/shadowsocks-libev/bin/obfs-local build/releases
# cp /home/runner/project/dists/shadowsocks-libev/bin/v2ray-plugin build/releases
# cp /home/runner/project/dists/shadowsocks-libev/bin/ck-client build/releases

cd build/releases
tar -zcvf shadowsocks-libev-ubuntu.tgz *