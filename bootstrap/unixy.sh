#! /bin/bash

echo "Installing pyenv"

source $HOME/.zprofile

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

# rust
echo "Installing rust"
if ! [[ -x $(command -v rustc) ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo " - rust already installed"
fi

pip3 install dotpup
