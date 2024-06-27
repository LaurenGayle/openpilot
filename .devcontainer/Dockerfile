FROM ghcr.io/commaai/openpilot-base:latest

RUN apt update && apt install -y vim net-tools usbutils htop ripgrep tmux wget mesa-utils xvfb libxtst6 libxv1 libglu1-mesa gdb bash-completion
RUN pip install ipython jupyter jupyterlab

# install vncserver
RUN apt-get update \
 && export DEBIAN_FRONTEND=noninteractive \
 && echo yes | apt-get install -y \
      dbus-x11 \
      supervisor \
      tigervnc-standalone-server \
      xfce4 \
      xfce4-goodies \
      xfce4-terminal \
      xserver-xorg-core \
      xterm \
      xvfb \
      x11vnc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir ~/.vnc \
 && /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd"
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

RUN cd /tmp && \
    ARCH=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
    curl -L -o virtualgl.deb "https://github.com/VirtualGL/virtualgl/releases/download/3.1.1/virtualgl_3.1.1_$ARCH.deb" && \
    dpkg -i virtualgl.deb

RUN usermod -aG video root

USER root

RUN cd $HOME && \
    curl -O https://raw.githubusercontent.com/commaai/agnos-builder/master/userspace/home/.tmux.conf && \
    curl -O https://raw.githubusercontent.com/commaai/agnos-builder/master/userspace/home/.vimrc

COPY rootfs /