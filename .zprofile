
export NVM_DIR="$HOME/.nvm"
[[ -s $NVM_DIR/nvm.sh ]] && . $NVM_DIR/nvm.sh  # This loads NVM

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/Library/Python/3.6/bin:$PATH:/home/linuxbrew/.linuxbrew/bin:$HOME/.poetry/bin"


case `uname` in
  Linux)
setxkbmap -option caps:swapescape
  ;;
esac
