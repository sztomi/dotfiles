[[ -f $HOME/.zsh_agentfix ]] && source $HOME/.zsh_agentfix

if [[ "$AGENT_MODE" != "true" ]] && [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:$PATH:/home/tamas/.modular/bin"
export VOLTA_HOME="$HOME/.volta"
export PATH="/home/linuxbrew/.linuxbrew/bin:$VOLTA_HOME/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export ZPLUG_HOME="$HOME/.zplug"

export ZPLUG_LOG_LOAD_SUCCESS=false
export ZPLUG_LOG_LOAD_FAILURE=false

source ~/.zplug/init.zsh

if (( ${+ZPLUG_LOADFILE} )); then
  touch $ZPLUG_LOADFILE
fi

export UMZ_PLAY_SOUND=1

# zplug
export SPACESHIP_VI_MODE_SHOW=false
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "aperezdc/zsh-fzy"
zplug "zsh-users/zsh-autosuggestions"
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme
zplug "ytakahashi/igit"
zplug "sztomi/undistract-me-zsh"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

if [[ -n "$npm_config_yes" ]] || [[ -n "$CI" ]] || [[ "$TERM_PROGRAM" == "vscode" ]] || [[ "$-" != *i* ]]; then
  export AGENT_MODE=true
else
  export AGENT_MODE=false
fi

source $HOME/.zsh_aliases

# History
setopt histignorespace
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# Vi mode: Esc -> normal mode, vim motions to edit the current line.
# KEYTIMEOUT=1 kills the ~0.4s Esc lag. Set before the binds below so they
# attach to viins (main keymap) and keep working in insert mode.
bindkey -v
export KEYTIMEOUT=1

# In normal mode, press 'v' to open the current command in $EDITOR.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

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
export CONAN_COLOR_DARK=1

LOCAL_RC=.zshrc_$(hostname)
if [ -f $LOCAL_RC ]; then
  source $LOCAL_RC
fi

source ~/.zprofile

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ "$AGENT_MODE" == "false" ]]; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

#source $HOME/.zsh_functions

source $HOME/.nx.zsh

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s) > /dev/null
    for key in ~/.ssh/id_*; do
        [[ -f $key && ! $key =~ \.pub$ ]] && ssh-add $key > /dev/null 2>&1
    done
fi

# Shell history: atuin where installed (Mac), mcfly elsewhere.
if command -v atuin >/dev/null; then
    eval "$(atuin init zsh --disable-up-arrow)"
elif command -v mcfly >/dev/null; then
    export MCFLY_LIGHT=TRUE
    export MCFLY_FUZZY=2
    export MCFLY_RESULTS=25
    eval "$(mcfly init zsh)"
fi

source $HOME/.config/broot/launcher/bash/br


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/tamas/.opam/opam-init/init.zsh' ]] || source '/Users/tamas/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

