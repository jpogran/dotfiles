# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jpogran/.oh-my-zsh

DEFAULT_USER="jpogran"

ZSH_THEME="agnoster"
#ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(zsh-syntax-highlighting syntax-highlighting git common-aliases bundler osx sublime vagrant)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/id_rsa"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/opt/puppetlabs/sdk/bin

export BEAKER_keyfile="$HOME/.ssh/id_rsa-acceptance"
export BEAKER_destroy="always"
export BEAKER_debug=true

export PUPPET_INSTALL_TYPE="agent"
export INSTALLATION_TYPE="git"

export BUNDLE_PATH=.bundle/gems
export BUNDLE_BIN=.bundle/bin

# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

eval "$(rbenv init -)"
