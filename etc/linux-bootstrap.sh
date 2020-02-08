# TODO convert this into a modular script instead of just a bunch of random notes

# Etcher - burn images
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

# Apt packages

balena-etcher-electron
transmission
transmission-daemon
neovim
nordvpn (look up instructions)
hyper (via some non cli way)
rclone
zsh
git
fzf
fonts-powerline
tmux
# Commented out in favour of nvm
# npm
python3-pip
tree
fd-find
ranger

curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client

# zsh setup
chsh -s /usr/bin/zsh 
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
code

git clone https://github.com/jdheyburn/dotfiles.git ~/dotfiles

# Execute before stuff is installed?
mkdir -p ~/.oh-my-zsh/custom/plugins
mkdir -p ~/.config/Code/User
mkdir -p ~/.config/Hyper

ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.hyper.js ~/.config/Hyper/.hyper.js
ln -s ~/dotfiles/.hyper.js ~/.hyper.js
ln -s ~/dotfiles/.oh-my-zsh/custom/common.zsh ~/.oh-my-zsh/custom/common.zsh
ln -s ~/dotfiles/vscode/vscode-settings.json ~/.config/Code/User/settings.json

git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# TODO - test the below
local GO_VERSION="1.13"
local OS="linux"
local ARCH="amd64"
local GO_FILENAME="go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
wget "https://dl.google.com/go/${GO_FILENAME}"
sudo tar -C /usr/local -xzf $GO_FILENAME
rm $GO_FILENAME
mkdir $HOME/go
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

go get -v golang.org/x/tools/gopls
github.com/golangci/golangci-lint/cmd/golangci-lint



# Hugo
# TODO check with how go is installed - can we remove the tmpdir?
local tmpdir=$(mktemp -d)
local cwd=$(pwd)
cd $tmpdir
local HUGO_VERSION="0.58.3"
wget "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
tar -zxvf "hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
sudo mv -v hugo /usr/local/bin
hugo version
cd $cwd
rm -rf $tmpdir

# Cryptomator
sudo add-apt-repository ppa:sebastian-stenzel/cryptomator
sudo apt-get update
sudo apt-get install cryptomator

# ncdu - disk usage analyser
local NCDU_VERSION="1.14.1"
local NCDU_FILENAME="ncdu-linux-x86_64-${NCDU_VERSION}.tar.gz"
wget "https://dev.yorhel.nl/download/${NCDU_FILENAME}"
tar -zxvf $NCDU_FILENAME
sudo mv -v ncdu /usr/local/bin
ncdu --version
rm $NCDU_FILENAME

# VirtualBox
# TODO check the fingerprint
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt-get install virtualbox

# Docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    gnupg-agent \
    software-properties-common
# TODO check the fingerprint
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

# Python pip stuff - should loop over this too
/usr/bin/python3 -m pip install -U autopep8 --user
/usr/bin/python3 -m pip install -U pylint --user


# install bat 
local BAT_VERSION="0.12.1"
local BAT_FILENAME="bat_${BAT_VERSION}_amd64.deb"
wget "https://github.com/sharkdp/bat/releases/download/v0.12.1/${BAT_FILENAME}"
sudo dpkg -i $BAT_FILENAME
bat --version
rm $BAT_FILENAME
# Remember to set alias cat="bat"


# NVM - node and npm manager
local NVM_VERSION="0.35.1"
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts --latest-npm

# Ansible setup
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
# TODO pull ansible config from github

# broot - better tree app
wget "https://dystroy.org/broot/download/x86_64-linux/broot"
chmod +x broot
sudo mv -v broot /usr/local/bin/


# Nix insallation
local NIX_VERSION="2.3.2"
curl -o "install-nix-$NIX_VERSION" https://nixos.org/nix/install
curl -o "install-nix-$NIX_VERSION.sig" https://nixos.org/nix/install.sig
gpg2 --recv-keys B541D55301270E0BCF15CA5D8170B4726D7198DE
gpg2 --verify "./install-nix-$NIX_VERSION.sig"
sh "./install-nix-$NIX_VERSION"
rm install-nix-*