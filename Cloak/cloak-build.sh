#!/bin/bash

PREFIX='/home/build'

git clone https://github.com/cbeuw/Cloak.git $PREFIX/Cloak
cd $PREFIX/Cloak

rm -rf $PREFIX/release/Cloak

go get ./...

env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/Cloak/linux/ck-server ./cmd/ck-server

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/Cloak/darwin/ck-server ./cmd/ck-server

env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/Cloak/freebsd/ck-server ./cmd/ck-server 

env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/Cloak/windows/ck-server.exe ./cmd/ck-server

env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/Cloak/linux/ck-client ./cmd/ck-client

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/Cloak/darwin/ck-client ./cmd/ck-client 

env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/Cloak/freebsd/ck-client ./cmd/ck-client 

env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -trimpath -ldflags " -s -w -X main.version=$(git describe --abbrev=0 --tags) -buildid=$(date +%FT%T%z)" -o $PREFIX/release/Cloak/windows/ck-client.exe ./cmd/ck-client 

chown -R build:build $PREFIX/release/Cloak
