#! /bin/sh

echo "Installing pyenv"

source $HOME/.zprofile

if ! [[ -x $(command -v pyenv) ]]; then
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh
else
  echo " - pyenv already installed"
fi
eval "$(pyenv init -)"

PYTHON_VERSION=3.6.4

if ! [[ $(pyenv versions | grep $PYTHON_VERSION ) ]]; then
  echo "Installing python $PYTHON_VERSION"
  pyenv install 3.6.4
fi

pyenv global 3.6.4

echo "Installing tpm"
if ! [[ -d $HOME/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
  echo " - tpm already installed"
fi

echo "Installing zplug"
if ! [ -d $HOME/.zplug ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
  echo " - zplug already installed"
fi

echo "Installing vim-plug"
if ! [[ -f $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo " - vim-plug already installed."
fi


pip3 install thefuck
pip3 install dotpup
pip3 install pipenv
