transmission
neovim
nordvpn (look up instructions)
hyper (via some non cli way)
rclone
zsh
git
fzf
fonts-powerline
tmux
npm

curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client

// zsh setup
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
local GO_FILENAME="go$GO_VERSION.$OS-$ARCH.tar.gz"
wget "https://dl.google.com/go/$GO_FILENAME"
sudo tar -C /usr/local -xzf $GO_FILENAME
rm $GO_FILENAME
mkdir $HOME/go
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

go get -v golang.org/x/tools/gopls
github.com/golangci/golangci-lint/cmd/golangci-lint

# TODO put into list and loop over
code --install-extension ms-vscode.go
pkief.material-icon-theme
equinusocio.vsc-material-theme

# Hugo
# TODO check with how go is installed - can we remove the tmpdir?
local tmpdir=$(mktemp -d)
local cwd=$(pwd)
cd $tmpdir
local HUGO_VERSION="0.58.3"
wget "https://github.com/gohugoio/hugo/releases/download/v$HUGO_VERSION/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
tar -zxvf "hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
sudo mv -v hugo /usr/local/bin
hugo version
cd $cwd
rm -rf $tmpdir

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
    software-properties-common
# TODO check the fingerprint
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
# TODO below doesn't work?
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
