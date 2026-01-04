set -U fish_greeting

set -gx TERMINAL_APP "ghostty.app"
set -gx HOMEBREW_NO_ANALYTICS 1
set -Ux LC_ALL en_US.UTF-8
set -Ux LANG en_US.UTF-8

# Core environment
set -gx EDITOR "code --wait"
set -gx VISUAL $EDITOR
set -gx PAGER less
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache

fish_add_path $HOME/.local/bin

abbr cls clear
abbr cd.. cd ..
abbr .. cd ..
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'

if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
    mise activate fish | source
    starship init fish | source
end
