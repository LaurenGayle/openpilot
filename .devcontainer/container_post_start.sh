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

#https://github.com/danchitnis/container-xrdp/blob/master/build/ubuntu-run.sh

start_xrdp_services() {
    # Preventing xrdp startup failure
    rm -rf /var/run/xrdp-sesman.pid
    rm -rf /var/run/xrdp.pid
    rm -rf /var/run/xrdp/xrdp-sesman.pid
    rm -rf /var/run/xrdp/xrdp.pid

    # Use exec ... to forward SIGNAL to child processes
    xrdp-sesman && exec xrdp -n
}

stop_xrdp_services() {
    xrdp --kill
    xrdp-sesman --kill
    exit 0
}

echo -e "starting xrdp services...\n"

trap "stop_xrdp_services" SIGKILL SIGTERM SIGHUP SIGINT EXIT
start_xrdp_services
