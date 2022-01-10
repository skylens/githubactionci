#!/usr/local/bin/env bash

PREFIX='/home/runner/project/dists/gost'

apt install -y --no-install-recommends git upx

git clone https://github.com/ginuerzh/gost.git

cd gost/cmd/gost

env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o linux/gost

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o darwin/gost

env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o freebsd/gost

env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o windows/gost.exe


git clone https://github.com/maskedeken/gost-plugin.git

cd gost-plugin

env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o linux/gost-plugin

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o darwin/gost-plugin

env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o freebsd/gost-plugin

env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags) -s -w -buildid=" -o windows/gost-plugin.exe