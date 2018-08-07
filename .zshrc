source ~/.zplug/init.zsh

# Make sure to use double quotes
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

# Then, source plugins and add commands to $PATH
zplug load

eval $(thefuck --alias)

export LC_ALL=C.UTF-8
export LANG=C.UTF-8
export EDITOR=nvim

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export DOTPUP_HOME="$HOME/dotfiles"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

