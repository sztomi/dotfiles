#! /bin/bash

declare -A PIP_PACKAGES=([fuck]='thefuck' [dpup]='dotpup' [pipenv]='pipenv')
for cmd in "${!PIP_PACKAGES[@]}"; do
  pkg=${PIP_PACKAGES[$cmd]}
  echo "Installing $pkg"
  if ! [[ -x $(command -v $cmd) ]]; then
    pip install $pkg
  else
    echo " - $pkg already installed"
  fi
done


declare -A BREW_PACKAGES=([fzy]='fzy' [git]='git' [nvim]='neovim')
for cmd in "${!BREW_PACKAGES[@]}"; do
  pkg=${PIP_PACKAGES[$cmd]}
  echo "Installing $pkg"
  if ! [[ -x $(command -v $cmd) ]]; then
    brew install $pkg
  else
    echo " - $pkg already installed"
  fi
done

brew cask install kitty
