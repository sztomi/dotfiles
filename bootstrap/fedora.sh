#! /bin/bash

echo "Installing Fedora packages"

# Install packages
sudo dnf install -y \
  zsh tmux make gcc-c++ openssl-devel zlib-devel bzip2-devel \
  readline-devel sqlite-devel wget curl llvm ncurses-devel \
  xz tk-devel libffi-devel xz-devel xbindkeys xclip gawk ncurses-compat-libs \
  gperf google-noto-emoji-fonts checksec util-linux-user \
  libnotify patchelf git-absorb \
  zstd dconf xclip

# GSettings command to update GNOME settings
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo "Running general linux steps"

#source $DIR/linux.sh
