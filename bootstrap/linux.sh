#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
echo "Running general Unix steps"
source $DIR/unixy.sh


echo "Setting shell to zsh"
if [ -n "$ZSH_VERSION" ]; then
  chsh -s $(which zsh)
else
  echo " - shell was already zsh"
fi


# linuxbrew
echo "Installing linuxbrew"
if ! [[ -d /home/linuxbrew ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
else
  echo " - linuxbrew already installed"
fi
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

declare -A BREW_PACKAGES=([fd]='fd' [nvim]='neovim' [fzy]='fzy' [rg]='ripgrep' [lsd]='lsd' [delta]='git-delta')
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
FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2"
echo "Installing fonts"
if ! [[ -f "$FONTS_HOME/$HACK_FONT" ]]; then
  FONT_FILES=("Hack.zip" "SourceCodePro.zip" "JetBrainsMono.zip")
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
