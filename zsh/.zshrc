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

export GOPATH=$HOME/src/go

DEFAULT_USER="jpogran"
POWERLEVEL9K_MODE='awesome-fontconfig'
ZSH_THEME="powerlevel9k/powerlevel9k"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(sudo git history common-aliases bundler osx vagrant node npm syntax-highlighting zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

function ni() {
  mkdir -p "$(dirname "$1")/" && touch "$1"
}

[ -f ~/.zsh.local ] && source ~/.zsh.local

eval "$(hub alias -s)"
eval "$(rbenv init -)"

source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
