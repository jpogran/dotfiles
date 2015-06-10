if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export PATH="/usr/local/sbin:/usr/local/bin:$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
