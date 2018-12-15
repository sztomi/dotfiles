export ZPLUG_HOME="$HOME/.zplug"
source ~/.zplug/init.zsh

# zplug

zplug "zsh-users/zsh-history-substring-search"
zplug "b4b4r07/enhancd", at:v1
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "supercrabtree/k"
zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# History

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
bindkey '^R' history-incremental-search-backward

# fuck

eval $(thefuck --alias)

case `uname` in
  Darwin)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHON_CONFIGURE_OPTS="--enable-framework"
  ;;

  Linux)
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
  ;;
esac

export NVM_DIR="$HOME/.nvm"
[[ -s $NVM_DIR/nvm.sh ]] && . $NVM_DIR/nvm.sh  # This loads NVM

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/Library/Python/3.6/bin:$PATH:$HOME/.linuxbrew/bin:$HOME/.poetry/bin:$(yarn global bin)"
export HOSTALIASES=$HOME/.hosts

export EDITOR=nvim
export DOTPUP_HOME="$HOME/dotfiles"
export TERM=xterm-256color
export CONAN_VERBOSE_TRACEBACK=1
export DOTNET_TELEMETRY_OPTOUT=1

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

source $HOME/.zsh_aliases
