#!/bin/bash

echo "Enter user password to verify user has sudo privileges"
is_sudo=$(sudo -v)
if [ $? -ne 0 ]; then
    echo 'Sudo privileges required - obtain them via the Self Service app "AdminRights_Temp"'
    exit 1
fi

if [[ $(uname) == 'Darwin' ]]; then
    which -s brew
    if [ $? != 0 ]; then
        echo 'Homebrew required - install it first before proceeding'
        exit 1
    fi
fi

set -e

install_apps=(
    python
    awscli
    wget
    golang
    azure-cli
    vault
    packer
    node
    tfenv
    iterm2
    fd
    trash
    tree
    dos2unix
)

cask_install_apps=(
    aws-vault
    java
    visual-studio-code
)

for install_app in ${install_apps[@]}; do
    brew install $install_app
done

for cask_install_app in ${cask_install_apps[@]}; do
    brew cask install $cask_install_app
done

# As of 2019-05-23 Terraform 0.12 was released which contains breaking changes
# tfenv helps us to install previous versions of terraform
# homebrew doesn't make it easy to do this otherwise
tfenv install 0.11.14

brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Powerline fonts
local cwd=$(pwd)
local tmpdir=$(mktemp -d)
cd $tmpdir
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd $cwd
rm -rf $tmpdir

# Some settings for iterm2 config, will probably need to make sure we've checked this out first
# Specify the preferences directory
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# Use plain text mode as default in TextEdit
defaults write com.apple.TextEdit RichText -int 0

# bootstrap git too
