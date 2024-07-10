FROM ghcr.io/commaai/openpilot-base:579b131a6efe67463d5b2d06abe743302c9cdc08

RUN apt update && apt install -y vim net-tools usbutils htop ripgrep tmux wget mesa-utils xvfb libxtst6 libxv1 libglu1-mesa gdb bash-completion python3-pip
RUN pip install --break-system-packages ipython jupyter jupyterlab

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

#install x2go server
# RUN apt-get update \
#     && apt-get install -y software-properties-common \
#     && add-apt-repository -y ppa:x2go/stable \
#     && apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get install -y \
#          x2goserver \
#          x2goserver-xsession \
#          openssh-server

# RUN useradd -m -U user
# RUN mkdir /var/run/sshd

# EXPOSE 22
# CMD ["/usr/sbin/sshd","-D"]

# #x11 forwarding
# RUN apt update \
#     && apt install -y firefox \
#                       openssh-server \
#                       xauth \
#     && mkdir /var/run/sshd \
#     && mkdir /root/.ssh \
#     && chmod 700 /root/.ssh \
#     && ssh-keygen -A \
#     && sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config \
#     && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
#     && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
#     && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

# RUN echo "YOUR_PUB_KEY_HERE" >> /root/.ssh/authorized_keys

# ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]

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