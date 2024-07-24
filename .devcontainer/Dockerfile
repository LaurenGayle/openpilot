FROM ghcr.io/commaai/openpilot-base:579b131a6efe67463d5b2d06abe743302c9cdc08

RUN apt update && apt install -y vim net-tools usbutils htop ripgrep tmux wget mesa-utils xvfb libxtst6 libxv1 libglu1-mesa gdb bash-completion python3-pip
RUN pip install --break-system-packages ipython jupyter jupyterlab

# # install vncserver
# RUN apt-get update \
#  && export DEBIAN_FRONTEND=noninteractive \
#  && echo yes | apt-get install -y \
#       dbus-x11 \
#       supervisor \
#       tigervnc-standalone-server \
#       xfce4 \
#       xfce4-goodies \
#       xfce4-terminal \
#       xserver-xorg-core \
#       xterm \
#       xvfb \
#       x11vnc \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/* \
#  && mkdir ~/.vnc \
#  && /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd"
# ENV TINI_VERSION v0.9.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
# RUN chmod +x /bin/tini

# #install x2go server
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

# #EXPOSE 22
# CMD ["/usr/sbin/sshd","-D"]


#setup xrdp (https://github.com/danchitnis/container-xrdp)
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin

    RUN apt-get install -y \
    sudo \
    wget \
    xorgxrdp \
    dbus-x11 \
    dbus \
    xrdp && \
    apt remove -y light-locker xscreensaver && \
    apt autoremove -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists

COPY ./build/ubuntu-run.sh /usr/bin/
RUN mv /usr/bin/ubuntu-run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

# https://github.com/danielguerra69/ubuntu-xrdp/blob/master/Dockerfile
RUN mkdir -p /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession

RUN update-rc.d dbus defaults && \
    service dbus restart && \
    dbus-run-session xterm &

# create a password
RUN echo "root:pass" | chpasswd

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

# # Docker config
# EXPOSE 3389
# ENTRYPOINT ["/usr/bin/run.sh"]