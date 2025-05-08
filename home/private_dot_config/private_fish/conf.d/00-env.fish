set -gx HOMEBREW_PREFIX "/opt/homebrew"

fish_add_path "$HOMEBREW_PREFIX/bin"
fish_add_path "$HOMEBREW_PREFIX/sbin"
fish_add_path "$HOMEBREW_PREFIX/opt/libpq/bin"

# Add homebrew completions
if test -e "$HOMEBREW_PREFIX/share/fish/completions"
    set -a fish_complete_path "$HOMEBREW_PREFIX/share/fish/completions"
end

# Other homebrew vars.
set -gx HOMEBREW_NO_ANALYTICS 1

# Set XDG basedirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

# Fish vars
set -q __fish_cache_dir; or set -Ux __fish_cache_dir $XDG_CACHE_HOME/fish
set -q __fish_plugins_dir; or set -Ux __fish_plugins_dir $__fish_config_dir/plugins
test -d $__fish_cache_dir; or mkdir -p $__fish_cache_dir

# Set browser on macOS.
switch (uname -s)
    case Darwin
        set -gx BROWSER open
end

# Ensure manpath is set to something so we can add to it.
set -q MANPATH; or set -gx MANPATH ''

# Add more man page paths.
for manpath in (path filter $__fish_data_dir/man /usr/local/share/man /usr/share/man)
    set -a MANPATH $manpath
end

# Set initial working directory.
set -g IWD $PWD

# XDG apps
set -q GNUPGHOME; or set -Ux GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx LESSHISTFILE $XDG_DATA_HOME/lesshst
set -gx SQLITE_HISTORY $XDG_DATA_HOME/sqlite_history

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -x EDITOR 'code --wait'

set -x SSH_AUTH_SOCK ~/.1password/agent.sock

set -gx LDFLAGS -L/opt/homebrew/opt/libpq/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/libpq/include

# Add the shims to the end of PATH as fallback for VS Code
# https://mise.jdx.dev/ide-integration.html#vscode
# set -x PATH $PATH ~/.local/share/mise/shims
