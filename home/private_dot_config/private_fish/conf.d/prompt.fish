# Disable new user greeting.
set fish_greeting

# Initialize starship.
type -q starship || return 1
# set -gx STARSHIP_CONFIG $__fish_config_dir/themes/mmc.toml
# cachecmd starship init fish | source
starship init fish | source
# enable_transience
