source ~/dots/bash_prompt

export CLICOLOR=1
export EDITOR=nvim
export LANG=en_US.UTF-8
export HISTCONTROL=ignoredups:erasedups
export MARKETPLACE=grailed
stty -ixon

alias ll='ls -la'
alias la='ls -a'
alias mkdir='mkdir -pv'
alias be='bundle exec'
alias h='history'
alias vi='nvim'
alias vim='nvim'

function grailed {
  export MARKETPLACE=grailed
}

function heroine {
  export MARKETPLACE=heroine
}

if [ -d /usr/local/sbin ] ; then
    PATH="$PATH:/usr/local/sbin"
fi

# bash completions
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# junk drawer programs
export PATH="$HOME/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### fzf!
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--color light'

# rbenv/ruby
eval "$(rbenv init -)"

# ssl setup
export PATH="/usr/local/opt/openssl/bin:$PATH"

# golang
export GOPATH=$HOME/work/go
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE=on

# elixir
export PATH="$PATH:/usr/local/opt/elixir/bin"

# py2
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"

# rust programs
export CARGO_PATH=$HOME/.cargo/bin
export PATH="$CARGO_PATH:$PATH"

export LOCAL_BIN_PATH=$HOME/.local/bin
export PATH="$LOCAL_BIN_PATH:$PATH"

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# nvm/node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

