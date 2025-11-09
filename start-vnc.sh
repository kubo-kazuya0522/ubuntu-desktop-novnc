#!/bin/bash
set -e

# ロケール設定
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP:ja
export LC_ALL=ja_JP.UTF-8

# VNCサーバ用ディレクトリ作成
mkdir -p ~/.vnc

# VNCパスワード設定
VNCPASSWD=$(which vncpasswd || echo /usr/local/bin/vncpasswd)
echo "vscode" | $VNCPASSWD -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# xstartup 設定
cat > ~/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# 既存の VNC サーバを停止
vncserver -kill :1 > /dev/null 2>&1 || true

# VNC サーバ起動
vncserver :1 -geometry 1280x720 -depth 24 -SecurityTypes None
echo "✅ VNC サーバ起動完了 (:1)"

# noVNC 起動
~/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &
echo "✅ noVNC サーバ起動中 → http://localhost:6080/"

# プロセス保持（コンテナ終了防止）
wait
