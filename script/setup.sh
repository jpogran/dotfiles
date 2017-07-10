
if [ ! -f ~/.iterm/themes/SolarizedDark.itermcolors ]; then
    # install SolarizedDark
    mkdir -p ~/.iterm/themes
    wget -O ~/.iterm/themes/SolarizedDark.itermcolors https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/Solarized%20Dark.itermcolors
    open ~/.iterm/themes/SolarizedDark.itermcolors
fi

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if [ ! -f ~/src/third/powerline-fonts ]; then
    git clone https://github.com/powerline/fonts.git ~/src/third/powerline-fonts
    cd ~/src/third/powerline-fonts
    ./install.sh
    cd ..
fi

rbenv install 2.4.1 -s
