# Common aliases and functions with my personal setup
# Should not contain anything firm-specific 

# Nice man pages - only works on Linux
# export PAGER='most'

# Code completions
source <(terraform-docs completion zsh)
# Path Adjustments
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Fix history
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt HIST_IGNORE_ALL_DUPS # ignore duplicated commands history list
setopt SHARE_HISTORY # share command history data

# Aliases
alias cl="clear"
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias awscf="vi ~/.aws/config"
alias gpm="git pull origin master"
alias mv="mv -v"
alias cp="cp -Rv"
#alias pbcopy="xclip -selection clipboard"
#alias pbpaste="xclip -selection clipboard -o"
# These are from zsh
alias pbcopy="clipcopy"
alias pbpaste="clippaste"

alias ranger=". ranger"
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific aliases
    alias rm="trash"    
    BATCAT_CMD="bat"
else
    # Debian / other specific aliases
    alias fd="fdfind"
    BATCAT_CMD="batcat"
fi

alias cat=$BATCAT_CMD

# zsh aliases
alias h="history" # an alias that points to omz_history
alias -s {zsh,yml,yaml,txt}=vim
alias -g G='| grep -i '
alias -g P=' | landscape > ~/tmp/plan.out 2>&1; cat ~/tmp/plan.out'

# PATHs and things
## gettext is keg-only, which means it was not symlinked into /usr/local,
## because macOS provides the BSD gettext library & some software gets confused if both are in the library path.
if [[ $OSTYPE =~ "darwin*" ]]; then
    export PATH="/usr/local/opt/gettext/bin:$PATH"
    ## For compilers to find gettext you may need to set:
    export LDFLAGS="-L/usr/local/opt/gettext/lib"
    export CPPFLAGS="-I/usr/local/opt/gettext/include"
fi

# Additional binaries that may exist in dotfiles repo
export PATH=$HOME/dotfiles/bin:$PATH

## Summary of plan - shows affected resources
alias -g splan='plan | landscape > ~/tmp/plan.out 2>&1; echo "--------------\nPlan Summary\n--------------\n" >> ~/tmp/plan.out; cat ~/tmp/plan.out | egrep "\+ [a-z]|- [a-z]|~ [a-z]|Plan:" >> ~/tmp/plan.out; cat ~/tmp/plan.out'

# outputs target changes from plan
function pgrep {
 egrep "$1" | cut -d " " -f2 ;
}

# Functions
# MakeChangedir - takes in a dir to create and then cd into
function mc {
    local dir=$1
    if [ -z "$dir" ]; then
        echo "mc - No dir was provided"
        return 1
    fi
    
    mkdir -p "$dir"
    cd "$dir"
}

# ConfigCommitPush - takes in a commit message for the config update and pushes to Bitbucket
#   - config is an alias defined above
function confcp {
    local commitMsg=$1
    if [ -z "$commitMsg" ]; then
        echo "confcp - No commit message was provided"
        return 1
    fi
    
    config commit -m "$commitMsg"
    config push
}

# SearchDirectory - recursive search through the targeted dir for the text in any file
function sd {
    local searchTerm=$1
    local searchDir=$2
    if [ -z "$searchTerm" ]; then
        echo "sd - No search term provided"
        return 1
    fi
    if [ -z "$searchDir" ]; then
        echo "sd - No dir specified - defaulting to current dir"
        searchDir="."
    fi
    
    grep --ignore-case --files-with-matches --recursive --no-messages --exclude-dir=".terraform" $searchTerm $searchDir
}

# UnZip - unzip the archive into a dir at the same location with the archive name
readlinkCmd="readlink"
if [[ "$OSTYPE" == "darwin"* ]]; then
    readlinkCmd="greadlink"
fi

function uz {
    local archive=$1
    if [ -z "$archive" ]; then
        echo "uz - No archive specified"
        return 1
    fi

    local archivePath=$($readlinkCmd -f $archive)
    if [ ! -f $archivePath ]; then
        echo "uz - Archive not found: $archivePath"
        return 1
    fi

    local extractDir=$(echo $archivePath | sed -e "s/.zip$//")
    if [ -e $extractDir ] && [ ! -d $extractDir ]; then
        echo "uz - ExtractDir exists but not as a directory: $extractDir"
    fi
    mkdir $extractDir
    unzip $archive -d $extractDir
}

# Third-party functions

##### fzf #### (https://github.com/junegunn/fzf)

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
function _fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
function _fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

