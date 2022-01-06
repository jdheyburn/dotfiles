# Common aliases and functions with my personal setup
# Should not contain anything firm-specific

# Nice man pages - only works on Linux
# export PAGER='most'

# Code completions
source <(terraform-docs completion zsh)
source <(kubectl completion zsh)

# Path Adjustments
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Fix history
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt HIST_IGNORE_ALL_DUPS # ignore duplicated commands history list
setopt SHARE_HISTORY        # share command history data

# Aliases
alias awscf="vi ~/.aws/config"
alias cl="clear"
alias cp="cp -Rv"
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias gpm="git pull origin $(git_main_branch)"
alias kc="kubectx"
alias kn="kubens"
alias mv="mv -v"
#alias pbcopy="xclip -selection clipboard"
#alias pbpaste="xclip -selection clipboard -o"
alias pbcopy="clipcopy"
alias pbpaste="clippaste"

alias vim="nvim"
alias vi="nvim"

alias venv="source .venv/bin/activate"

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
alias tf="terraform"

# zsh aliases
alias h="history" # an alias that points to omz_history
alias -s {zsh,yml,yaml,txt}=vim
alias -g G='| grep -i '
alias -g P=' | landscape > ~/tmp/plan.out 2>&1; cat ~/tmp/plan.out'


# kubectl krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# PATHs and things
## gettext is keg-only, which means it was not symlinked into /usr/local,
## because macOS provides the BSD gettext library & some software gets confused if both are in the library path.
if [[ $OSTYPE =~ "darwin*" ]]; then
    export PATH="/usr/local/opt/gettext/bin:$PATH"
    ## For compilers to find gettext you may need to set:
    export LDFLAGS="-L/usr/local/opt/gettext/lib"
    export CPPFLAGS="-I/usr/local/opt/gettext/include"
fi

## Summary of plan - shows affected resources
alias -g splan='plan | landscape > ~/tmp/plan.out 2>&1; echo "--------------\nPlan Summary\n--------------\n" >> ~/tmp/plan.out; cat ~/tmp/plan.out | egrep "\+ [a-z]|- [a-z]|~ [a-z]|Plan:" >> ~/tmp/plan.out; cat ~/tmp/plan.out'

# outputs target changes from plan
function pgrep() {
    egrep "$1" | cut -d " " -f2
}

# Functions
# GitCommitMsg - adds the JIRA ticketed branch named to the commit message
unalias gcmsg
function gcmsg() {
    setopt local_options BASH_REMATCH

    local msg=$@
    if [ -z "$msg" ]; then
        echo "gcmsg - no message was provided"
        return 1
    fi

    local curr_branch=$(git_current_branch)
    local regex="^[A-Z]{2,}\-[0-9]+"
    if [[ $curr_branch =~ $regex ]]; then
        local ticket="${BASH_REMATCH[1]}"
        local msg="$ticket - $msg"
    fi

    git commit -m "$msg"
}

# makechangedir - takes in a dir to create and then cd into
function mc() {
    local dir=$1
    if [ -z "$dir" ]; then
        echo "mc - no dir was provided"
        return 1
    fi

    mkdir -p "$dir"
    cd "$dir"
}

# ConfigCommitPush - takes in a commit message for the config update and pushes to Bitbucket
#   - config is an alias defined above
function confcp() {
    local commitMsg=$1
    if [ -z "$commitMsg" ]; then
        echo "confcp - No commit message was provided"
        return 1
    fi

    config commit -m "$commitMsg"
    config push
}

# SearchDirectory - recursive search through the targeted dir for the text in any file
function sd() {
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

function uz() {
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

# Given a pod name this will return the primary pod in a redis k8s cluster
function get-k8s-redis-primary() {
    local pod=$1
    if [ -z "$pod" ]; then
        echo "get-k8s-redis-primary - No pod specified"
        echo "choose from below"
        kubectl get pods --namespace redis
        return 1
    fi

    local cluster_ip=$(kubectl exec $pod -- redis-cli -p 26379 info G ^master | awk '{split($0,a,","); print a[3]}' | awk '{split($0,a,"="); print a[2]}' | awk '{split($0,a,":"); print a[1]}')

    if [ -z "$cluster_ip" ]; then
        echo "get-k8s-redis-primary - could not find master for pod $pod"
        return 1
    fi

    kubectl get services | grep $cluster_ip
}

# Change AWS instance type by hostname
function modify-aws-instance-type() {
    local hostname=$1
    if [ -z $hostname ]; then
        echo "ERR: hostname not provided, usage:"
        echo "  modify-aws-instance-type HOSTNAME INSTANCE_TYPE"
        return 1
    fi
    local instance_type=$2
    if [ -z $instance_type ]; then
        echo "ERR: instance_type not provided, usage:"
        echo "  modify-aws-instance-type HOSTNAME INSTANCE_TYPE"
        return 1
    fi

    local describe_instance=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$hostname")

    local instance_id=$(echo "$describe_instance" | jq -r '.Reservations[].Instances[0].InstanceId')
    if [ -z $instance_id ]; then
        echo "ERR: InstanceId not found for $hostname"
        return 1
    fi

    echo "$hostname -> $instance_id"

    local curr_instance_type=$(echo "$describe_instance" | jq -r '.Reservations[].Instances[0].InstanceType')
    if [[ "$instance_type" == "$curr_instance_type" ]]; then
        echo "$hostname instance type is already $instance_type"
        return 0
    fi
    echo "$hostname instance_type: $curr_instance_type"

    local validate_instance_type=$(aws ec2 describe-instance-types --instance-types $instance_type | jq -r '.InstanceTypes[0].InstanceType')
    if [[ "$validate_instance_type" != "$instance_type" ]]; then
        echo "ERR: $instance_type is not a valid instance type"
        return 1
    fi

    local state=$(echo "$describe_instance" | jq -r '.Reservations[].Instances[0].State.Name')
    local stopped="false"
    if [[ "$state" != "stopped" ]]; then
        echo "stopping $hostname"
        local state=$(aws ec2 stop-instances --instance-ids $instance_id | jq -r '.StoppingInstances[0].CurrentState.Name')
        while [[ "$state" != "stopped" ]]; do
            echo "waiting for $hostname / $instance_id state = 'stopped', currently $state"
            sleep 5
            local state=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$hostname" | jq -r '.Reservations[].Instances[0].State.Name')
        done
    fi

    echo "$hostname stopped. modifying instance type to $instance_type"

    if ! aws ec2 modify-instance-attribute --instance-id $instance_id --instance-type $instance_type; then
        return 1
    fi

    echo "starting $hostname"

    local state=$(aws ec2 start-instances --instance-ids $instance_id | jq -r '.StartingInstances[0].CurrentState.Name')
    echo "$hostname is in $state state"
    return 0
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
