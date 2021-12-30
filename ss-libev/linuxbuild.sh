#!/bin/bash

PREFIX='/home/runner/project/dists'

sudo apt-get install --no-install-recommends -y upx

ver=1.2.11
wget https://zlib.net/zlib-$ver.tar.gz
tar -xvf zlib-$ver.tar.gz
cd zlib-$ver
./configure --prefix=$PREFIX/zlib --static --libdir=$PREFIX/zlib/lib
make && make install
cd ..

ver=8.45
wget https://sourceforge.net/projects/pcre/files/pcre/$ver/pcre-$ver.tar.gz
# wget https://ftp.pcre.org/pub/pcre/pcre-$ver.tar.gz
tar zxf pcre-$ver.tar.gz
cd pcre-$ver
./configure --prefix=$PREFIX/pcre --disable-shared --enable-utf8 --enable-unicode-properties
make && make install
cd ..

ver=2.16.6
wget --no-check-certificate https://tls.mbed.org/download/mbedtls-$ver-gpl.tgz
tar zxf mbedtls-$ver-gpl.tgz
cd mbedtls-$ver
LDFLAGS=-static make DESTDIR=$PREFIX/mbedtls install
# make lib && make install
cd ..

ver=1.0.18
wget --no-check-certificate https://download.libsodium.org/libsodium/releases/libsodium-$ver.tar.gz
tar zxf libsodium-$ver.tar.gz
cd libsodium-$ver
./configure --prefix=$PREFIX/libsodium --disable-shared
make && make install
cd ..

ver=4.33
wget http://dist.schmorp.de/libev/libev-$ver.tar.gz 
tar zxf libev-$ver.tar.gz
cd libev-$ver
./configure --prefix=$PREFIX/libev --disable-shared
make && make install
cd ..

ver=1.17.1
wget https://c-ares.haxx.se/download/c-ares-$ver.tar.gz
tar zxf c-ares-$ver.tar.gz
cd c-ares-$ver
./configure --prefix=$PREFIX/cares --disable-shared
make && make install 
cd ..

git clone https://github.com/shadowsocks/shadowsocks-libev
cd shadowsocks-libev
git submodule init && git submodule update
./autogen.sh
# LDFLAGS="-static" CFLAGS="-static" \
LIBS="-lpthread -lm" LDFLAGS="-Wl,-static -static -static-libgcc -L$PREFIX/libsodium/lib" CFLAGS="-I$PREFIX/libsodium/include" \
./configure --prefix=$PREFIX/shadowsocks-libev \
--disable-documentation \
--with-mbedtls=$PREFIX/mbedtls \
--with-pcre=$PREFIX/pcre \
--with-cares=$PREFIX/cares \
--with-sodium=$PREFIX/libsodium \
--with-ev=$PREFIX/libev
make && make install
cd ..

git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
LIBS="-lpthread -lm" LDFLAGS="-Wl,-static -static -static-libgcc" \
./configure --prefix=$PREFIX/shadowsocks-libev \
--disable-documentation \
--with-ev=$PREFIX/libev
make
make install
cd ..

git clone https://github.com/shadowsocks/v2ray-plugin
cd v2ray-plugin
env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o v2ray-plugin-linux
cp v2ray-plugin-linux $PREFIX/shadowsocks-libev/bin/v2ray-plugin
cd ..

git clone https://github.com/cbeuw/Cloak
cd Cloak
env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o ck-client-linux ./cmd/ck-client
cp ck-client-linux $PREFIX/shadowsocks-libev/bin/ck-client
cd ..

mkdir -p build/releases
cp $PREFIX/shadowsocks-libev/bin/ss-* build/releases
cp $PREFIX/shadowsocks-libev/bin/obfs-local build/releases
cp $PREFIX/shadowsocks-libev/bin/v2ray-plugin build/releases
cp $PREFIX/shadowsocks-libev/bin/ck-client build/releases

cd build/releases
ldd *
upx *
tar -zcvf shadowsocks-libev-ubuntu.tgz *