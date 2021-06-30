# macOSCI


```
git clone https://github.com/shadowsocks/ShadowsocksX-NG.git

git clone https://github.com/skylens/ShadowsocksX-NG.git

xcodebuild clean -workspace /Users/runner/ShadowsocksX-NG/ShadowsocksX-NG.xcworkspace -scheme ShadowsocksX-NG -configuration Release

xcodebuild archive -workspace /Users/runner/ShadowsocksX-NG/ShadowsocksX-NG.xcworkspace -scheme ShadowsocksX-NG -archivePath /Users/runner/archive/ShadowsocksX-NG.xcarchive

cd /Users/runner/archive/ShadowsocksX-NG.xcarchive/Products/Applications
```