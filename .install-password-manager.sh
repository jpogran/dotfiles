#!/bin/sh

if [ -n "${CODESPACES}" ]; then
    log "Exit. Skip install-password-manager for codespaces."
    exit
fi

# exit immediately if password-manager-binary is already in $PATH
type op >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
    brew install 1password-cli
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
