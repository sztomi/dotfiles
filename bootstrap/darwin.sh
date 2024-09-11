#! /bin/bash
# this is pre-4.0 bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if ! [[ -x $(command -v brew) ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 
else
  echo " - brew is already installed"
fi

export PATH="/Users/tamas/.pyenv/bin:$PATH"

if ! [[ -x $(command -v pyenv) ]]; then
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | $SHELL
else
  echo " - pyenv already installed"
fi

eval "$(pyenv init -)"

PYTHON_VERSION=3.9.18

if ! [[ $(pyenv versions | grep $PYTHON_VERSION ) ]]; then
  echo "Installing python $PYTHON_VERSION"
  pyenv install 3.9.18
fi

pyenv global 3.9.18

if ! [[ -f /usr/local/bin/bash ]]; then
  brew install bash
fi

/opt/homebrew/bin/bash $DIR/darwin2.bash4

