#!/bin/bash

PREFIX='/home/build'

git clone https://github.com/shadowsocks/v2ray-plugin $PREFIX/v2ray-plugin
cd $PREFIX/v2ray-plugin

rm -rf $PREFIX/release/v2ray-plugin

env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/v2ray-plugin/linux/v2ray-plugin

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/v2ray-plugin/darwin/v2ray-plugin

env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/v2ray-plugin/freebsd/v2ray-plugin

env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/v2ray-plugin/windows/v2ray-plugin.exe

chown -R build:build $PREFIX/release/v2ray-plugin
