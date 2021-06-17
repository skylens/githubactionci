# macOSCI

```


      - name: build
        run: |
          brew reinstall autoconf automake c-ares libev mbedtls libsodium git
          mkdir ~/shadowsocks-libev-macOS
          cd ~/
          wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz
          tar -xvf ~/shadowsocks-libev-3.3.5.tar.gz
          pushd ~/shadowsocks-libev-3.3.5
          ./configure --prefix=~/shadowsocks-libev-macOS --disable-documentation && make
          sudo make install
          popd
          tar -zcvf ~/shadowsocks-libev-macOS.tar.gz ~/shadowsocks-libev-macOS

      - name: scp
        run: |
          eval "$(ssh-agent -s)"
          ssh-add - <<< "${{ secrets.SSH_KEY }}"
          [ -d ~/.ssh ] || mkdir ~/.ssh
          echo "StrictHostKeyChecking no" >> ~/.ssh/config
          scp -r ~/shadowsocks-libev-macOS.tar.gz ${{ secrets.USER }}@${{ secrets.REMOTESERVERIP }}:${{ secrets.REMOTEDIR }}

```

libev

```
wget http://dist.schmorp.de/libev/libev-4.33.tar.gz
```