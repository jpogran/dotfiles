# Go configuration
set -gx GOPATH $HOME/go
fish_add_path $GOPATH/bin

# Enable Go modules
# set -gx GO111MODULE auto

# Configure GOPROXY for better dependency management
# set -gx GOPROXY "https://proxy.golang.org,direct"

# Improve Go tests output readability
set -gx GOTESTSUM_FORMAT dots-v2
