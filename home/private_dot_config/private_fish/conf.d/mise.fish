mise activate fish | source

# Ensure mise shims are on the PATH
set -xp PATH $HOME/.local/share/mise/shims

# Add mise completions
if test -d $HOME/.local/share/mise/completions
    source $HOME/.local/share/mise/completions/mise.fish
end

# Mise aliases
abbr -a mr 'mise run'
abbr -a mt 'mise trust'
abbr -a mi 'mise install'
abbr -a mu 'mise use'
abbr -a ml 'mise ls'
