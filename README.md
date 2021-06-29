# macOSCI

```

      - name: build
        run: |
          brew reinstall autoconf automake cmake c-ares libev mbedtls libsodium git
          mkdir ~/shadowsocks-libev-macOS
          cd ~/
          wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz
          tar -xvf ~/shadowsocks-libev-3.3.5.tar.gz
          pushd ~/shadowsocks-libev-3.3.5
          ./configure --prefix=/Users/runner/shadowsocks-libev-macOS --disable-documentation && make
          cd build && cmake ../ && make
          popd
          tar -zcf ~/shadowsocks-libev-macOS.tar.gz /Users/runner/shadowsocks-libev-3.3.5/*

      - name: build
        run: |
          brew reinstall autoconf automake cmake c-ares libev mbedtls libsodium git
          mkdir ~/shadowsocks-libev-macOS
          cd ~/
          wget https://tls.mbed.org/download/mbedtls-2.16.6-gpl.tgz
          wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz
          wget https://c-ares.haxx.se/download/c-ares-1.17.1.tar.gz
          wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz
          tar -xvf ~/shadowsocks-libev-3.3.5.tar.gz
          pushd ~/shadowsocks-libev-3.3.5
          ./configure --prefix=/Users/runner/shadowsocks-libev-macOS --disable-documentation \
          --with-mbedtls-include=/Users/runner/mbedtls-2.16.6 \
          --with-sodium-include=/Users/runner/libsodium-1.0.18 \ 
          && make
          cd build && cmake ../ && make
          popd
          tar -zcf ~/shadowsocks-libev-macOS.tar.gz /Users/runner/shadowsocks-libev-3.3.5/*
```

libev

```
wget http://dist.schmorp.de/libev/libev-4.33.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.45.tar.gz
wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz
wget https://raw.githubusercontent.com/skylens/macOSCI/main/Makefile
 tar -zcf ~/shadowsocks-libev-macOS.tar.gz ~/shadowsocks-libev-macOS/*
```


```
xcodebuild clean -workspace /Users/runner/ShadowsocksX-NG/ShadowsocksX-NG.xcworkspace -scheme ShadowsocksX-NG -configuration Release

xcodebuild archive -workspace /Users/runner/ShadowsocksX-NG/ShadowsocksX-NG.xcworkspace -scheme ShadowsocksX-NG -archivePath /Users/runner/archive/ShadowsocksX-NG.xcarchive

/Users/runner/archive/ShadowsocksX-NG.xcarchive/Products/Applications

```