#! /bin/sh

sudo pkg install zsh python3 git fzy neovim bash bzip2 sqlite \
  curl gcc gmake libstdc++_stldoc_4.2.2 ntp openjdk8 wget     \
  autoconf v4l_compat sqlite3 gperf


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
echo "Running general Unix steps"
source $DIR/unixy.sh
