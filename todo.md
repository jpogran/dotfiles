defaults write com.apple.LaunchServices "LSQuarantine" -bool "false"
defaults write com.apple.TimeMachine "DoNotOfferNewDisksForBackup" -bool "true"
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "true" && killall Finder
defaults write com.apple.finder "CreateDesktop" -bool "true" && killall Finder
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "3" && killall Finder
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" && killall Finder
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv" && killall Finder
defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true" && killall Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "false" && killall Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" && killall Finder
defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true" && killall Safari
mkdir ~/Pictures/screenshots
defaults write com.apple.screencapture "location" -string "~/Pictures/screenshots" && killall SystemUIServer
defaults write com.apple.dock "show-recents" -bool "false" && killall Dock
defaults write com.apple.dock "mineffect" -string "scale" && killall Dock
defaults write com.apple.dock "autohide-delay" -float "0" && killall Dock
defaults write com.apple.dock "autohide" -bool "true" && killall Dock
defaults write com.apple.dock "orientation" -string "left" && killall Dock
defaults delete com.apple.finder; killall Finder
defaults delete com.apple.dock; killall Dock
