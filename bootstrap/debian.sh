#! /bin/bash

echo "Installing yarn"
if ! [ -x $(command -v yarn) ]; then
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
else
  echo "yarn already installed"
fi

echo "Installing debian packages"

sudo apt update

sudo apt install -y zsh tmux make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev xbindkeys xclip gawk
sudo apt install -y yarn --no-install-recommends

sudo snap install lsd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo "Running general linux steps"

source $DIR/linux.sh
