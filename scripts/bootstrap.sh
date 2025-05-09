#!/bin/bash
# bootstrap.sh - Set up a new macOS system

set -e

echo "🚀 Starting system bootstrap..."

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for the current script
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

# Install chezmoi and dotfiles if not already done
if ! command -v chezmoi &> /dev/null; then
    echo "🏠 Installing chezmoi and dotfiles..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply {{ .data.username }}
fi

# Set fish as default shell if it isn't already
if ! grep -q fish /etc/shells; then
    echo "🐟 Adding fish to /etc/shells..."
    echo "$(which fish)" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != *"fish"* ]]; then
    echo "🐟 Setting fish as default shell..."
    chsh -s "$(which fish)"
fi

echo "✅ Bootstrap complete! You may need to restart your terminal."
