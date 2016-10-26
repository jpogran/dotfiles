export ZSH=/Users/jpogran/.oh-my-zsh

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(syntax-highlighting git sublime brew bundler jira ruby rvm vagrant)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/id_rsa"

alias cls="clear"
alias code-"cd ~/src"
