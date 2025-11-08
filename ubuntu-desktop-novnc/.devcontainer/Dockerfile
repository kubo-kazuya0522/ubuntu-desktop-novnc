FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

# 基本ツール・VNC・noVNC・XFCE4 のインストール
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo vim curl git locales \
    xfce4 xfce4-session xfce4-terminal xfce4-goodies dbus-x11 xterm \
    tigervnc-standalone-server novnc websockify && \
    locale-gen ja_JP.UTF-8 && update-locale LANG=ja_JP.UTF-8 && \
    useradd -m -s /bin/bash vscode && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
WORKDIR /home/vscode

EXPOSE 6080
CMD ["bash", "/workspaces/ubuntu-desktop-novnc/ubuntu-desktop-novnc/start-vnc.sh"]
