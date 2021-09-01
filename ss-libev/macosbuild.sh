#!/bin/bash

PREFIX='/Users/runner/project/dists'

brew install automake upx

ver=1.2.11
wget https://zlib.net/zlib-$ver.tar.gz
tar -xvf zlib-$ver.tar.gz
cd zlib-$ver
./configure --prefix=$PREFIX/zlib --static --libdir=$PREFIX/zlib/lib
make && make install
cd ..

ver=8.45
wget https://ftp.pcre.org/pub/pcre/pcre-$ver.tar.gz
tar zxf pcre-$ver.tar.gz
cd pcre-$ver
./configure --prefix=$PREFIX/pcre --disable-shared --enable-utf8 --enable-unicode-properties
make && make install
cd ..

wget https://sourceforge.net/projects/ijbswa/files/Sources/3.0.32%20%28stable%29/privoxy-3.0.32-stable-src.tar.gz
tar zxf privoxy-3.0.32-stable-src.tar.gz
cd privoxy-3.0.32-stable
# git clone https://www.privoxy.org/git/privoxy.git
# cd privoxy
autoheader
autoconf -i
LDFLAGS="-L$PREFIX/zlib/lib -L$PREFIX/pcre/lib" ./configure --prefix=$PREFIX/privoxy
make && make install
cd ..

ver=2.16.6
wget --no-check-certificate https://tls.mbed.org/download/mbedtls-$ver-gpl.tgz
tar zxf mbedtls-$ver-gpl.tgz
cd mbedtls-$ver
LDFLAGS=-static make DESTDIR=$PREFIX/mbedtls lib && make DESTDIR=$PREFIX/mbedtls install
cd ..

ver=1.0.18
wget --no-check-certificate https://download.libsodium.org/libsodium/releases/libsodium-$ver.tar.gz
tar zxf libsodium-$ver.tar.gz
cd libsodium-$ver
./configure --prefix=$PREFIX/libsodium --disable-ssp --disable-shared
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
./configure --prefix=$PREFIX/shadowsocks-libev \
--disable-documentation \
--with-mbedtls=$PREFIX/mbedtls \
--with-pcre=$PREFIX/pcre \
--with-cares=$PREFIX/cares \
--with-sodium=$PREFIX/libsodium \
--with-ev=$PREFIX/libev
make && make install
cd ..

git clone https://github.com/shadowsocks/simple-obfs
cd simple-obfs
git submodule init && git submodule update
./autogen.sh
./configure --prefix=$PREFIX/shadowsocks-libev \
--disable-documentation \
--with-ev=$PREFIX/libev
make && make install
cd ..

git clone https://github.com/shadowsocks/v2ray-plugin
cd v2ray-plugin
env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o v2ray-plugin-darwin
cp v2ray-plugin-darwin $PREFIX/shadowsocks-libev/bin/v2ray-plugin
cd ..

git clone https://github.com/cbeuw/Cloak
cd Cloak
env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o ck-client-darwin ./cmd/ck-client
cp ck-client-darwin $PREFIX/shadowsocks-libev/bin/ck-client
cd ..

mkdir -p build/releases
cp $PREFIX/privoxy/sbin/privoxy build/releases
cp $PREFIX/shadowsocks-libev/bin/ss-* build/releases
cp $PREFIX/shadowsocks-libev/bin/obfs-local build/releases
cp $PREFIX/shadowsocks-libev/bin/v2ray-plugin build/releases
cp $PREFIX/shadowsocks-libev/bin/ck-client build/releases

cd build/releases
otool -L *
upx *
gtar -zcvf shadowsocks-libev-macos.tgz *