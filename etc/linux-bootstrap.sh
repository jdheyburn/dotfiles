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
local GOLANG_VERSION="1.13"
local tmpdir=$(mktemp -d)
cd $tmpdir
wget "https://dl.google.com/go/go$GOLANG_VERSION.linux-amd64.tar.gz"
tar -zxvf "go$GOLANG_VERSION.linux-amd64.tar.gz"
cd go/src
./all.bash



