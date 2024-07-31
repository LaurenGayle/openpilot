#!/usr/bin/env bash

TARGET_USER=root
source .devcontainer/.host/.env

# override display flag for mac hosts
if [[ $HOST_OS == darwin ]]; then
  echo "Setting up DISPLAY override for macOS..."
  cat <<EOF >> /home/$TARGET_USER/.bashrc
source .devcontainer/.host/.env
if [ -n "\$HOST_DISPLAY" ]; then
  DISPLAY_NUM=\$(echo "\$HOST_DISPLAY" | awk -F: '{print \$NF}')
  export DISPLAY=host.docker.internal:\$DISPLAY_NUM
fi
EOF
fi

# setup virtualgl for mac hosts
if [[ $HOST_OS == darwin ]]; then
  echo "Setting up virtualgl for macOS..."
  cat <<EOF >> /home/$TARGET_USER/.bashrc
if [ -n "\$HOST_DISPLAY" ]; then
  export VGL_PORT=10000
  export VGL_CLIENT=host.docker.internal
  export VGL_COMPRESS=rgb
  export VGL_DISPLAY=:99
  export VGL_FPS=60
  # prevent vglrun from running exec
  alias exec=:; source vglrun :; unalias exec
fi
EOF
fi

# These lines are temporary, to remain backwards compatible with old devcontainers
# that were running as root and therefore had their caches written as root
chown -R $TARGET_USER: /tmp/scons_cache
chown -R $TARGET_USER: /tmp/comma_download_cache
chown -R $TARGET_USER: /home/root/.comma


wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda-repo-ubuntu2004-11-2-local_11.2.0-460.27.04-1_amd64.deb
dpkg -i cuda-repo-ubuntu2004-11-2-local_11.2.0-460.27.04-1_amd64.deb
apt-key add /var/cuda-repo-ubuntu2004-11-2-local/7fa2af80.pub

apt-get -y update
apt-get -y install cuda-toolkit-11-2
