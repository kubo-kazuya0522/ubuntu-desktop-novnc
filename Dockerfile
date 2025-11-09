# ベースイメージ
FROM ubuntu:22.04

# 非対話モードに設定
ENV DEBIAN_FRONTEND=noninteractive

# 基本ツールと VNC, XFCE4 デスクトップをインストール
RUN apt-get update && apt-get install -y \
    tigervnc-standalone-server \
    tigervnc-common \
    xfce4 xfce4-terminal \
    wget curl sudo git \
    console-setup keyboard-configuration \
    locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ロケール設定
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# 日本語キーボード設定（非対話）
RUN echo 'keyboard-configuration  keyboard-configuration/layoutcode  select  jp' | debconf-set-selections && \
    echo 'keyboard-configuration  keyboard-configuration/modelcode   select  pc105' | debconf-set-selections && \
    echo 'keyboard-configuration  keyboard-configuration/variantcode select  Japanese' | debconf-set-selections && \
    echo 'keyboard-configuration  keyboard-configuration/toggle   select  No toggling' | debconf-set-selections && \
    dpkg-reconfigure -f noninteractive keyboard-configuration

# vscode ユーザー作成
RUN useradd -m -s /bin/bash vscode || true
USER vscode
WORKDIR /home/vscode

# start-vnc.sh をコピーして権限付与
COPY --chown=vscode:vscode start-vnc.sh /home/vscode/start-vnc.sh
RUN chmod +x /home/vscode/start-vnc.sh

# コンテナ起動時に自動で VNC 起動
CMD ["/home/vscode/start-vnc.sh"]
