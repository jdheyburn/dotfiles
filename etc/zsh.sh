#!/usr/bin/env bash

function oh_my_zsh_setup() {
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Plugins - this could be replaced with submodules https://github.com/enriquecaballero/dotfiles/tree/master/zsh
    echo "Installing oh-my-zsh plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

function addCustomZshFiles() {
    for f in $(ls -d $HOME/dotfiles/.oh-my-zsh/custom/*.zsh); do
        echo "Symlinking $f to ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}" 
        ln -sf $f ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
    done
}

function validate() {
    if ! which -s zsh; then
        echo "zsh not found, skipping execution of $0"
        exit 1
    fi
}

function main() {
    validate

    oh_my_zsh_setup

    addCustomZshFiles
}

main $@
