#!/bin/bash

function setup() {
    mkdir -p $HOME/.config/nvim
    ln -fs $HOME/dotfiles/.config/nvim/init.vim $HOME/.config/nvim/init.vim
}

function main() {
    setup
}

main $@
