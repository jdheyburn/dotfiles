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

    local sourcePath="${fpath}/${fname}.${ext}"
    local dstPath="/mnt/usb/Backup/lms/${fname}_${now}.${ext}"

    echo "starting pcp backup"
    ssh -i /home/jdheyburn/.ssh/pcp tc@pcp.joannet.casa -C 'pcp bu'

    echo "copying $sourcePath on remote to $dstPath"
    scp -i /home/jdheyburn/.ssh/pcp "tc@pcp.joannet.casa:${sourcePath}" $dstPath
}

function main() {
    echo "entered $0"
    pcp
}

main $@
