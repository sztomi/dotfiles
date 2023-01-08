#! /bin/bash

echo "Installing debian packages"

DEBIAN_FRONTEND=noninteractive

sudo apt update

sudo apt install -y 
  zsh tmux make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev xbindkeys xclip gawk libtinfo5 gperf \
  fonts-noto-color-emoji devscripts libnotify-bin notify-send patchelf git-absorb \
  zstd flatpak gnome-software-plugin-flatpak dconf-cli dconf-editor
sudo apt install -y yarn --no-install-recommends

dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo "Running general linux steps"

source $DIR/linux.sh
