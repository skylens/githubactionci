#!/bin/bash

brew install automake gsed

# -target x86_64-apple-macos10.12
# -target arm64-apple-macos11


# export RELAY_DEPS_PATH=./build-deps/arm64
# export PKG_CONFIG_PATH=./build-deps/arm64/lib/pkgconfig

# cd ./relay-deps
# TARGET=./build-deps make install

# cd ./relay
# phpize
# ./configure CFLAGS='-target arm64-apple-macos' \
#   --host=aarch64-apple-darwin \
#   --enable-relay-jemalloc-prefix
#   [snip...]

# make

# # Dynamically linked binary
# cc --target=arm64-apple-darwin \
#   ${wl}-flat_namespace ${wl}-undefined ${wl}suppress \
#   -o .libs/relay.so -bundle .libs/*.o \
#   -L$RELAY_DEPS_PATH/lib -lhiredis -ljemalloc_pic [snip...]

# # re-link to standard paths
# ./relay-deps/utils/macos/relink.sh .libs/relay.so /usr/local/lib
# cp .libs/relay.so modules/relay.so

# # Build a statically linked shared object
# cc --target=arm64-apple-darwin \
#   ${wl}-flat_namespace ${wl}-undefined ${wl}suppress \
#   -o .libs/relay-static.so -bundle .libs/*.o \
#   $RELAY_DEPS_PATH/lib/libhiredis.a \
#   $RELAY_DEPS_PATH/lib/libjemalloc_pic.a \
#   [snip...]


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
gsed -i "s/DESTDIR=\/usr\/local/DESTDIR=\/Users\/runner\/project\/dists\/mbedtls/g" Makefile
make SHARED=0 && make install
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

cp /Users/runner/project/dists/mbedtls/lib/libmbedcrypto.dylib /Users/runner/project/dists/shadowsocks-libev/bin/

cd /Users/runner/project/

gtar zcvf ~/shadowsocks-libev-macOS-`date +%Y-%m-%d-%s`.tgz dists/