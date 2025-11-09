#!/bin/bash
set -e

# デフォルト VNC パスワード
VNC_PASS=${VNC_PASS:-vscode}

# .vnc ディレクトリ作成
mkdir -p /home/vscode/.vnc
chmod 700 /home/vscode/.vnc

# パスワード設定
echo "$VNC_PASS" | vncpasswd -f > /home/vscode/.vnc/passwd
chmod 600 /home/vscode/.vnc/passwd

# 既存 VNC サーバーを停止
vncserver -kill :1 || true
pkill Xtigervnc || true

# xstartup 作成
cat << 'EOF' > /home/vscode/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4
EOF
chmod +x /home/vscode/.vnc/xstartup

# VNC サーバー起動
vncserver :1 -geometry 1920x1080 -depth 24

# noVNC 起動（ポート 6080 でブラウザアクセス）
/home/vscode/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &

echo "VNC server started on display :1 (port 5901)"
echo "noVNC available at http://localhost:6080"
wait
