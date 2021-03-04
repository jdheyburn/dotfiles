#!/bin/bash

DIR=$(realpath $(dirname $0))
CONF_LOC="$HOME/.config/beets"

function main() {
    local file="config-$1".yaml
    if [ ! -f $DIR/$file ]; then
        echo "Could not find $DIR/$file"
        exit 1
    fi
    rm -f $CONF_LOC/config.yaml
    ln -s $DIR/$file $CONF_LOC/config.yaml
}

main $@
