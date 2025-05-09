#!/bin/bash
# macOS system preferences script

# Close System Preferences to prevent overriding settings
osascript -e 'tell application "System Preferences" to quit'

# Finder
echo "Configuring Finder preferences..."
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder CreateDesktop -bool true
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 3
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowPathbar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Screenshots
echo "Setting up screenshots location..."
mkdir -p ~/Pictures/screenshots
defaults write com.apple.screencapture location -string "~/Pictures/screenshots"

# Dock
echo "Configuring Dock preferences..."
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "left"

# Safari
echo "Configuring Safari preferences..."
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# System
echo "Configuring system preferences..."
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Restart affected applications
echo "Restarting affected applications..."
killall Finder
killall Dock
killall SystemUIServer
killall Safari

echo "macOS defaults have been set!"
