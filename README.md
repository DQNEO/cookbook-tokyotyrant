# This cookbook installs TokyoTyrant and TokyoCabinet
# TokyoTyrant & TokyoCabinetをインストールする
# 

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

# 起動テスト
sudo /usr/local/sbin/ttservctl start

# 別ウィンドウからtelnetで動作確認
telnet localhost 1978
set foo 0 0 3
get foo

# テスト終了
sudo /usr/local/sbin/ttservctl stop

# 起動スクリプトを作る
sudo mv /usr/local/sbin/ttservctl /etc/init.d/ttservd
sudo nano /etc/init.d/ttserv  # 適宜修正

# 自動起動設定
sudo /sbin/chkconfig --list
sudo /sbin/chkconfig --add ttservd
sudo /sbin/chkconfig ttservd on

# サーバ再起動して、ttservdが自動起動するか確認
sudo /sbin/shutdown -r now
```

# 起動スクリプトを修正

```
diff --git a/etc/init.d/ttservd b/etc/init.d/ttservd
index 596302e..e96a7c8 100755
--- a/etc/init.d/ttservd
+++ b/etc/init.d/ttservd
@@ -1,4 +1,7 @@
 #! /bin/sh
+# chkconfig: 345 65 55
+# description: Startup script for the server of Tokyo Tyrant For Session
+# processname: tokyotyrant

 #----------------------------------------------------------------
 # Startup script for the server of Tokyo Tyrant
@@ -6,19 +9,19 @@

 # configuration variables
-prog="ttservctl" 
-cmd="ttserver" 
+prog="ttservd" 
+cmd="/usr/local/bin/ttserver" 
 basedir="/var/ttserver" 
 port="1978" 
 pidfile="$basedir/pid" 
-#logfile="$basedir/log" 
+logfile="/var/log/ttserver.log" 
 #ulogdir="$basedir/ulog" 
 #ulimsiz="256m" 
 #sid=1
 #mhost="remotehost1" 
 #mport="1978" 
 #rtsfile="$basedir/rts" 
-dbname="$basedir/casket.tch#bnum=1000000" 
+dbname="$basedir/casket.tch#bnum=1000000#dfunit=8" 
 retval=0
```
