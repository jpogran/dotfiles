#!/usr/bin/env fish

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -U fish_greeting

set -x EDITOR 'code --wait'

# Add the shims to the end of PATH as fallback for VS Code
# https://mise.jdx.dev/ide-integration.html#vscode
# set -x PATH $PATH ~/.local/share/mise/shims
# set -x PATH $PATH ~/Applications/bin ~/.npm/bin ~/.cargo/bin

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/libpq/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/libpq/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/libpq/include"

if status is-interactive
    eval "$(tfcdev rc)"
    # echo "$(doormat login && doormat artifactory create-token | jq -r '.access_token')" \
    #   | docker login -u "${USER}@hashicorp.com" --password-stdin docker.artifactory.hashicorp.engineering

    mise activate fish | source

    /opt/homebrew/bin/brew shellenv | source

    starship init fish | source
end
