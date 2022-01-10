#!/bin/bash

PREFIX='/home/build'

git clone https://github.com/ginuerzh/gost.git $PREFIX/gost
cd $PREFIX/gost

rm -rf $PREFIX/release/gost

env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/gost/linux/gost ./cmd/gost

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/gost/darwin/gost ./cmd/gost

env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/gost/freebsd/gost ./cmd/gost

env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/gost/windows/gost.exe ./cmd/gost

git clone https://github.com/maskedeken/gost-plugin.git $PREFIX/gost-plugin
cd $PREFIX/gost-plugin

rm -rf $PREFIX/release/gost-plugin

env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/gost-plugin/linux/gost-plugin

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/gost-plugin/darwin/gost-plugin

env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/gost-plugin/freebsd/gost-plugin

env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/gost-plugin/windows/gost-plugin.exe

chown -R build:build $PREFIX/release/gost*