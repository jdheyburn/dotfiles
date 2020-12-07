#!/usr/bin/env bash

# Main entrypoint for a *nix system, should handle both macOS and Linux

declare -a UNIX_SETUP=(
    "vscode.sh"
    "vim.sh"
    "zsh.sh"
)

function main() {


    if [[ "$OSTYPE" == "darwin"* ]]; then
        bash macos-bootstrap.sh
    else
        bash linux-bootstrap.sh
    fi

    bash golang.sh
}

main $@
