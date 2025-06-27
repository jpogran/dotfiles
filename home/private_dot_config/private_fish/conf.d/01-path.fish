#!/usr/bin/env fish

# Centralized PATH management
# System paths
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin

# User paths
fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin

# Language-specific paths
fish_add_path $HOME/go/bin
