#!/usr/bin/env bash

source .devcontainer/.host/.env

# setup safe directories for submodules
SUBMODULE_DIRS=$(git config --file .gitmodules --get-regexp path | awk '{ print $2 }')
for DIR in $SUBMODULE_DIRS; do
  git config --global --add safe.directory "$PWD/$DIR"
done

# virtual display for virtualgl
if [[ "$HOST_OS" == "darwin" ]] && [[ -n "$HOST_DISPLAY" ]]; then
  echo "Starting virtual display at :99 ..."
  tmux new-session -d -s fakedisplay Xvfb :99 -screen 0 1920x1080x24
fi

#install the vnc things
sudo mv /var/lib/dpkg/info/fuse.* /tmp

apt-get update
export DEBIAN_FRONTEND=noninteractive
apt-get install -y \
  supervisor\
  tigervnc-standalone-server

sudo mv /var/lib/dpkg/info/fuse.* /tmp

apt-get install -y \
  xfce4 \
  xfce4-goodies \
  xfce4-terminal \
  xserver-xorg-core \
  xterm \
  xvfb \
  x11vnc

apt-get clean
rm -rf /var/lib/apt/lists/*
mkdir ~/.vnc
/bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd"