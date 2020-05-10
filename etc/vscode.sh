#!/bin/bash

declare -a EXTENSIONS=(
    "ms-vscode.go"
    "pkief.material-icon-theme"
    "equinusocio.vsc-material-theme"
    "esbenp.prettier-vscode"
    "CoenraadS.bracket-pair-colorizer"
    "streetsidesoftware.code-spell-checker"
    "ms-python.python"
    "eamodio.gitlens"
    "DavidAnson.vscode-markdownlint"
    "foxundermoon.shell-format"
)

function validate() {
    which code
    if [ $? != 0 ]; then
        echo "VSCode required - install it first before proceeding"
        exit 1
    fi
}

function installExts() {
    for ext in "${EXTENSIONS[@]}"; do
        code --install-extension $ext
    done
}

function main() {
    validate

    installExts
}

main $@
