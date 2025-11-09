# ベースイメージ
FROM ubuntu:22.04

# 基本ツールと VNC, XFCE4 デスクトップをインストール
RUN apt-get update && apt-get install -y \
    tigervnc-standalone-server \
    tigervnc-common \
    xfce4 xfce4-terminal \
    wget curl sudo git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# vscode ユーザー作成（Codespaces は通常 vscode ユーザー）
RUN useradd -m -s /bin/bash vscode || true
USER vscode
WORKDIR /home/vscode

# start-vnc.sh をコピーして権限付与
COPY --chown=vscode:vscode start-vnc.sh /home/vscode/start-vnc.sh
RUN chmod +x /home/vscode/start-vnc.sh

# コンテナ起動時に自動で VNC 起動
CMD ["/home/vscode/start-vnc.sh"]
