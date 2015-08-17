# Path to your oh-my-zsh installation.
export ZSH=/Users/jpogran/.oh-my-zsh

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
JIRA_RAPID_BOARD="true"

plugins=(zsh-syntax-highlighting git sublime brew bundler jira ruby rvm vagrant)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

source /opt/boxen/env.sh
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='mvim'
export SSH_KEY_PATH="~/.ssh/id_rsa"

alias cls="clear"
