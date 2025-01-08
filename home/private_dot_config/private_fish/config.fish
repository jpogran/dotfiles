set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -U fish_greeting

# Add the shims to the end of PATH as fallback for VS Code
# https://mise.jdx.dev/ide-integration.html#vscode
# set -x PATH $PATH ~/.local/share/mise/shims

set -x PATH $PATH ~/Applications/bin ~/.npm/bin ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    mise activate fish | source

    /opt/homebrew/bin/brew shellenv | source

    starship init fish | source
end
