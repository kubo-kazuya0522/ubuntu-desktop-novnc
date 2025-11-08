# ベースイメージ
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

# 基本ツール・XFCE4・VNC・noVNC のインストール
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo vim curl git locales xfce4 xfce4-goodies xterm dbus-x11 \
    tigervnc-standalone-server tigervnc-tools python3 python3-pip wget \
    fonts-ipafont ibus-mozc && \
    locale-gen ja_JP.UTF-8 && update-locale LANG=ja_JP.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

# vscode ユーザー作成
RUN useradd -m -s /bin/bash vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
WORKDIR /home/vscode

# noVNC の最新版を GitHub から取得
RUN git clone https://github.com/novnc/noVNC.git ~/noVNC && \
    git clone https://github.com/novnc/websockify.git ~/noVNC/utils/websockify

# 起動スクリプトをコピー
COPY start-vnc.sh /home/vscode/start-vnc.sh
RUN chmod +x /home/vscode/start-vnc.sh

# noVNC 用ポート
EXPOSE 6080

# コンテナ起動時に VNC + noVNC を起動
CMD ["bash", "/home/vscode/start-vnc.sh"]
