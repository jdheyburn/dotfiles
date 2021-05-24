if [[ "$TMUX" == "" ]] && [[ "$SSH_CONNECTION" != "" ]]; then
    exec tmux new -A -s $(whoami)
fi
