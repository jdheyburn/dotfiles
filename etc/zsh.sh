#!/bin/bash

function oh_my_zsh_setup() {
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Plugins - this could be replaced with submodules https://github.com/enriquecaballero/dotfiles/tree/master/zsh
    echo "Installing oh-my-zsh plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    local target="$HOME/dotfiles/.oh-my-zsh/custom/common.zsh"
    local source="$ZSH_CUSTOM/common.zsh"
    echo "Adding symlink from $source to $target"
    ln -sf $target $source
}

function validate() {
    if ! which zsh; then
        echo "zsh not found, skipping execution of $0"
        exit 1
    fi
}

function main() {
    validate

    oh_my_zsh_setup
}

main $@
