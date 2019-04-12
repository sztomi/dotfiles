#! /bin/sh

sudo pkg install zsh python3 git fzy neovim bash bzip2 sqlite

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
echo "Running general Unix steps"
source $DIR/unixy.sh
