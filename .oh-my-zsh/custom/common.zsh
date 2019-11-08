# Common aliases and functions with my personal setup
# Should not contain anything firm-specific 

# Nice man pages - only works on Linux
# export PAGER='most'

# Aliases
alias cl=clear
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias awscf="vi ~/.aws/config"
alias gpm="git pull origin master"
alias mv="mv -v"
alias cp="cp -Rv"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias cat="bat"
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific aliases
    alias rm="trash"    
else
    # Debian / other specific aliases
    alias fd="fdfind"
fi


# zsh aliases
alias h='history' # an alias that points to omz_history
alias -s {yml,yaml}=vim
alias -g G='| grep -i '
alias -g P=' | landscape > ~/tmp/plan.out 2>&1; cat ~/tmp/plan.out'

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

