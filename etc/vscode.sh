#!/usr/bin/env bash

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
    "bbenoist.nix"
    "dunstontc.viml"
    "hashicorp.terraform"
    "golang.go"
)

function validate() {
    if ! which -s code; then
        echo "VSCode required - install it first before proceeding"
        exit 1
    fi
}

function installExts() {
    for ext in "${EXTENSIONS[@]}"; do
        code --install-extension $ext --force
    done
}

function setConfig() {
    if [[ $OSTYPE =~ "darwin*" ]]; then
        local settingsPath="$HOME/Library/Application Support/Code/User"
    else
        local settingsPath="$HOME/.config/Code/User"
    fi

    mkdir -p $settingsPath
    # In case of existing file
    mv -f "$settingsPath/settings.json" "$settingsPath/settings_bak.json"
    ln -sf "$HOME/dotfiles/vscode/vscode-settings.json" "$settingsPath/settings.json"
}

function main() {
    validate

    installExts

    setConfig

    echo "vscode setup done - you may need to restart vscode for changes to be in effect"
}

main $@
