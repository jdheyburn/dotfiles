#!/bin/bash

# Some settings for iterm2 config, will probably need to make sure we've checked this out first
# Specify the preferences directory
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# Use plain text mode as default in TextEdit
defaults write com.apple.TextEdit RichText -int 0

# bootstrap git too

function validate() {
    echo "macos-bootstrap.sh validate not yet implemented"
}

function installBrewPkgs() {
    if ! which -s brew; then
        echo "brew not found - installing now"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "brew installed"

    # Brewfile should be sitting in the same directory at this file\
    local brewPath=$(dirname $(greadlink -f $0))
    if [ ! -e "$brewPath/Brewfile" ]; then
        echo "Brewfile not found, aborting brew packages"
        return
    fi
    echo "Installing brew packages"
    brew bundle --file $brewPath/Brewfile
}

function installPowerlineFonts() {
    local cwd=$(pwd)
    local tmpdir=$(mktemp -d)
    cd $tmpdir
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd $cwd
    rm -rf $tmpdir
}

function main() {
    validate

    installPowerlineFonts

    installBrewPkgs
}

main $@
