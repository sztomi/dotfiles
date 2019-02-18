case `uname` in
  Linux)
setxkbmap -option caps:swapescape
  ;;
esac


export NVM_DIR="$HOME/.nvm"
[[ -s $NVM_DIR/nvm.sh ]] && . $NVM_DIR/nvm.sh  # This loads NVM

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/Library/Python/3.6/bin:$PATH:/home/linuxbrew/.linuxbrew/bin:$HOME/.poetry/bin:$(yarn global bin):$(python -c 'import subprocess as sp; print(sp.check_output("gem environment gempath", shell=True).decode().split(":")[0])')/bin"
