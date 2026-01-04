#!/bin/bash

set -e  # Exit on error

echo "🚀 Starting machine bootstrap process..."

echo "📦 Checking for Xcode Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
    echo "Xcode CLI tools not found. Installing them silently..."
    # Create a flag file to indicate installation is in progress
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    # Find the correct package name for the current OS version
    PROD=$(softwareupdate -l | grep "\\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
    # Install the package
    softwareupdate -i "$PROD" --verbose
else
    echo "Xcode CLI tools are already installed."
fi

# Install mise
echo "📦 Installing mise..."
if ! command -v mise &> /dev/null; then
    curl https://mise.run | sh

    # Add mise to PATH for this session
    export PATH="$HOME/.local/bin:$PATH"

    # Source mise activation
    if [ -f "$HOME/.local/share/mise/shims" ]; then
        eval "$($HOME/.local/bin/mise activate bash)"
    fi

    # technically we should add it to profile, but we use chezmoi to manage that
    # if chezmoi fails, then this will install mise again next time
else
    echo "   mise already installed"
fi

# Install mise packages
echo "📦 Installing chezmoi via mise..."
mise use -g chezmoi@latest

# Install Homebrew
echo "📦 Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH (for Apple Silicon Macs)
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    # For Intel Macs
    elif [ -f /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "   Homebrew already installed, updating..."
    brew update
fi

# Install brew packages
# echo "📦 Installing Homebrew packages..."
# brew install 1password
# brew install gh

# Execute chezmoi
echo "🔧 Executing chezmoi..."
if command -v chezmoi &> /dev/null; then
    chezmoi init --apply github.com/jpogran/dotfiles --branch refactor
    echo "   Run 'chezmoi apply' to apply your dotfiles when ready"
else
    echo "⚠️  Warning: chezmoi not found in PATH. You may need to restart your shell."
fi

echo "✨ Bootstrap complete!"
