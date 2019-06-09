#zmodload zsh/zprof 
touch $ZPLUG_LOADFILE
export ZPLUG_HOME="$HOME/.zplug"

export ZPLUG_LOG_LOAD_SUCCESS=false
export ZPLUG_LOG_LOAD_FAILURE=false

source $HOME/.zprofile
source ~/.zplug/init.zsh

# zplug

export SPACESHIP_VI_MODE_SHOW=false
zplug "zsh-users/zsh-history-substring-search"
zplug "b4b4r07/enhancd", at:v1
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "aperezdc/zsh-fzy"
zplug "zsh-users/zsh-autosuggestions"
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

source $HOME/.zsh_aliases

# History
setopt histignorespace
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget
bindkey '^P'  fzy-proc-widget
bindkey '^ ' autosuggest-execute

case `uname` in
  Darwin)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHON_CONFIGURE_OPTS="--enable-framework"
  ;;

  FreeBSD)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
  ;;

  Linux)
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
  ;;
esac

export HOSTALIASES=$HOME/.hosts

export EDITOR=nvim
export DOTPUP_HOME="$HOME/dotfiles"
export TERM=xterm-256color
export CONAN_VERBOSE_TRACEBACK=1
export DOTNET_TELEMETRY_OPTOUT=1

if [[ -x $(command -v pyenv) ]]; then
  if [[ -z "$POETRY_ACTIVE" ]]; then
    eval "$(pyenv init -)"
  fi
fi


#zprof
