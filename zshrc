export ZSH=$HOME/.oh-my-zsh
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/id_rsa"
export BEAKER_keyfile="$HOME/.ssh/id_rsa-acceptance"
export BEAKER_destroy="always"
export BEAKER_debug=true
export PUPPET_INSTALL_TYPE="agent"
export INSTALLATION_TYPE="git"
export BUNDLE_PATH=.bundle/gems
export BUNDLE_BIN=.bundle/bin

DEFAULT_USER="jpogran"
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(zsh-syntax-highlighting syntax-highlighting git common-aliases bundler osx vagrant node npm)

source $ZSH/oh-my-zsh.sh

function ni() {
  mkdir -p "$(dirname "$1")/" && touch "$1"
}

function all-up() {
  vagrant up master pe-agent
  vagrant suspend master pe-agent
  vagrant up pullserver dsc-agent
  vagrant suspend pullserver dsc-agent
}

function all-down() {
  vagrant suspend
}

function puppet-up() {
  vagrant up master pe-agent
}

function dsc-up() {
  vagrant up pullserver dsc-agent
}

function puppet-suspend() {
  vagrant suspend master pe-agent
}

function dsc-suspend() {
  vagrant suspend pullserver dsc-agent
}

[ -f ~/.zsh.local ] && source ~/.zsh.local

eval "$(hub alias -s)"
eval "$(rbenv init -)"
