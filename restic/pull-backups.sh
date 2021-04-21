#!/usr/bin/env bash

# Invoke and pull backups from remote servers and place them on USB

function pcp() {

    local fpath="/mnt/mmcblk0p2/tce"
    local fname="mydata"
    local ext="tgz"
    local now=$(date -u +"%Y-%m-%dT%H%M%S")
    local dstPath="/mnt/usb/Backup/lms/*.${ext}"

    echo "removing previous backups..."
    rm -rf $dstPath

    local sourceFile="${fpath}/${fname}.${ext}"
    local dstFile="/mnt/usb/Backup/lms/${fname}_${now}.${ext}"

    echo "starting pcp backup"
    ssh -i /home/jdheyburn/.ssh/pcp tc@pcp.joannet.casa -C 'pcp bu'

    echo "copying $sourceFile on remote to $dstFile"
    scp -i /home/jdheyburn/.ssh/pcp "tc@pcp.joannet.casa:${sourceFile}" $dstFile
}

function main() {
    echo "entered $0"
    pcp
}

main $@
