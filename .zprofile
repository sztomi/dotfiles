setxkbmap -option caps:swapescape

export NVM_DIR="$HOME/.nvm"
[[ -s $NVM_DIR/nvm.sh ]] && . $NVM_DIR/nvm.sh  # This loads NVM

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/Library/Python/3.6/bin:$PATH:$HOME/.linuxbrew/bin:$HOME/.poetry/bin:$(yarn global bin)"
