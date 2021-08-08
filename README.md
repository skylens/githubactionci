# macOSCI


```
git clone https://github.com/shadowsocks/ShadowsocksX-NG.git

git clone https://github.com/skylens/ShadowsocksX-NG.git

xcodebuild clean -workspace /Users/runner/ShadowsocksX-NG/ShadowsocksX-NG.xcworkspace -scheme ShadowsocksX-NG -configuration Release

xcodebuild archive -workspace /Users/runner/ShadowsocksX-NG/ShadowsocksX-NG.xcworkspace -scheme ShadowsocksX-NG -archivePath /Users/runner/archive/ShadowsocksX-NG.xcarchive

cd /Users/runner/archive/ShadowsocksX-NG.xcarchive/Products/Applications
```

scp 

```
eval "$(ssh-agent -s)"
ssh-add - <<< "${{ secrets.SSH_KEY }}"
[ -d ~/.ssh ] || mkdir ~/.ssh
echo "StrictHostKeyChecking no" >> ~/.ssh/config
scp -r esxi-unlocker-*.tgz ${{ secrets.USER }}@${{ secrets.REMOTESERVERIP }}:${{ secrets.REMOTEDIR }}
```


### Navicat Keygen

https://notabug.org/doublesine/navicat-keygen

https://github.com/wxlg1117/DoubleLabyrinth-navicat-keygen/tree/mac

https://github.com/VAllens/navicat-keygen

https://github.com/robotneo/navicat-keygen.git

