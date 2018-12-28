#! /bin/bash

echo "Installing pyenv"

source $HOME/.zprofile

if ! [[ -x $(command -v pyenv) ]]; then
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
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
if ! [[ -d $HOME/.zplug ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
  echo " - zplug already installed"
fi

echo "Setting shell to zsh"
if [ -n "$ZSH_VERSION" ]; then
  chsh -s $(which zsh)
else
  echo " - shell was already zsh"
fi

echo "Installing colorls"
if ! [[ -x $(command -v colorls) ]]; then
  gem install --user-install colorls
else
  echo " - colorls already installed"
fi

declare -A PIP_PACKAGES=([fuck]='thefuck' [dpup]='dotpup')
for cmd in "${!PIP_PACKAGES[@]}"; do
  pkg=${PIP_PACKAGES[$cmd]}
  echo "Installing $pkg"
  if ! [[ -x $(command -v $cmd) ]]; then
    pip install $pkg
  else
    echo " - $pkg already installed"
  fi
done


echo "Installing node"
if ! [[ -x $(command -v node) ]]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [[ -s $NVM_DIR/nvm.sh ]] && . $NVM_DIR/nvm.sh  # This loads NVM
  nvm install node
else
  echo " - node already installed"
fi


echo "Installing vim-plug"
if ! [[ -f $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo " - vim-plug already installed."
fi

# kitty terminal
echo "Installing kitty"
if ! [[ -d $HOME/.local/kitty.app ]]; then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
  sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop
else
  echo " - kitty already installed"
fi

# linuxbrew
echo "Installing linuxbrew"
if ! [[ -d /home/linuxbrew ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
else
  echo " - linuxbrew already installed"
fi


declare -A BREW_PACKAGES=([fd]='fd' [nvim]='neovim' [fzy]='fzy')
for cmd in "${!BREW_PACKAGES[@]}"; do
  pkg=${BREW_PACKAGES[$cmd]}
  echo "Installing $pkg"
  if ! [[ -x $(command -v $cmd) ]]; then
    brew install $pkg
  else
    echo " - $pkg already installed"
  fi
done


# fonts

HACK_FONT="Hack Regular Nerd Font Complete.ttf"
FONTS_HOME="$HOME/.local/share/fonts"
FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0"
echo "Installing fonts"
if ! [[ -f "$FONTS_HOME/$HACK_FONT" ]]; then
  FONT_FILES=("Hack.zip" "SourceCodePro.zip")
  for i in "${!FONT_FILES[@]}"; do
    font=${FONT_FILES[$i]}
    wget "$FONTS_URL/$font"
    unzip $font -d $FONTS_HOME
    rm $font
  done
  fc-cache -f -v
else
  echo " - fonts already installed"
fi
