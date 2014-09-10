# A cookbook to install TokyoTyrant and TokyoCabinet

TokyoTyrant & TokyoCabinetをインストールする

このCookbookがやっていることを手順書にすると以下のような感じです。

逆に言うと、このCookbookを使えば以下の作業を全部自動でやってくれます。

素敵！

## インストール

```
# ソースコードを取得してインストール
cd /usr/local/src

# TCインストール
wget http://fallabs.com/tokyocabinet/tokyocabinet-1.4.48.tar.gz
tar xvfz tokyocabinet-1.4.48.tar.gz
cd tokyocabinet-1.4.48
./configure
make
sudo make install

# TTインストール
wget http://fallabs.com/tokyotyrant/tokyotyrant-1.1.41.tar.gz
tar xvfz tokyotyrant-1.1.41.tar.gz
cd ../tokyotyrant-1.1.41
./configure
make
sudo make install

# 起動スクリプトを作る
sudo mv /usr/local/sbin/ttservctl /etc/init.d/ttservd
```

## 動作確認

```
# 起動テスト
sudo /usr/local/sbin/ttservctl start

# 別ウィンドウからtelnetで動作確認
telnet localhost 1978
set foo 0 0 3
get foo

# テスト終了
sudo /usr/local/sbin/ttservctl stop
```

## 起動スクリプトを修正

(git logを見ればわかるので省略)

## 自動起動設定

```
sudo /sbin/chkconfig --list
sudo /sbin/chkconfig --add ttservd
sudo /sbin/chkconfig ttservd on
```

最後にサーバを再起動して、ttservdが自動起動するか確認しましょう。

```
sudo /sbin/shutdown -r now
```
