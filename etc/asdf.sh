#!/usr/bin/env bash

declare -a progs
progs["helm"]="2.16.5"
progs["terraform"]="0.12.21"

function validate() {
    if ! which asdf; then
        echo "asdf not found, skipping execution of $0"
        exit 1
    fi
}

function installAsdfProgs() {
    # TODO implement
}

function main() {

    validate

}

main $@
