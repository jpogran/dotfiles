# Ruby configuration
set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=(brew --prefix openssl)"

# Bundler settings
set -gx BUNDLE_PATH ".bundle"
set -gx BUNDLE_BIN ".bundle/bin"
set -gx PATH $PATH $BUNDLE_BIN

# Add rbenv if installed
if test -d $HOME/.rbenv
    set -gx PATH $HOME/.rbenv/bin $PATH
    status --is-interactive; and rbenv init - fish | source
end

# Add chruby if installed
if test -d /opt/homebrew/opt/chruby
    source /opt/homebrew/opt/chruby/share/chruby/chruby.fish
    source /opt/homebrew/opt/chruby/share/chruby/auto.fish
end
