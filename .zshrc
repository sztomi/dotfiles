# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#zmodload zsh/zprof

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export ZPLUG_HOME="$HOME/.zplug"

export ZPLUG_LOG_LOAD_SUCCESS=false
export ZPLUG_LOG_LOAD_FAILURE=false

source ~/.zplug/init.zsh

if (( ${+ZPLUG_LOADFILE} )); then
  touch $ZPLUG_LOADFILE
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/Library/Python/3.6/bin:$PATH:/home/linuxbrew/.linuxbrew/bin:$HOME/.poetry/bin"


case `uname` in
  Linux)
setxkbmap -option caps:swapescape
  ;;
esac

# zplug

export SPACESHIP_VI_MODE_SHOW=false
zplug "zsh-users/zsh-history-substring-search"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "aperezdc/zsh-fzy"
zplug "zsh-users/zsh-autosuggestions"
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme

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
export PLZ_SCRIPTS_PATH=$DOTPUP_HOME/scripts
export TERM=xterm-256color
export CONAN_VERBOSE_TRACEBACK=1
export DOTNET_TELEMETRY_OPTOUT=1

LOCAL_RC=.zshrc_$(hostname)
if [ -f $LOCAL_RC ]; then
  source $LOCAL_RC
fi

if [[ -x $(command -v pyenv) ]]; then
  if [[ -z "$POETRY_ACTIVE" ]]; then
    eval "$(pyenv init -)"
  fi
fi

source ~/pure10k.zsh

#zprof

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
