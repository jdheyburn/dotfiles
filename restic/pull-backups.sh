#!/usr/bin/env bash

# Invoke and pull backups from remote servers and place them on USB

function pcp() {
    local fpath="/mnt/mmcblk0p2/tce"
    local fname="mydata"
    local ext="tgz"
    local now=$(date -u +"%Y-%m-%dT%H%M%S")
    ssh -i ~/.ssh/pcp tc@pcp.joannet.casa -C 'pcp bu'
    scp -i ~/.ssh/pcp "tc@pcp.joannet.casa:${fpath}/${fname}.${ext}" "/mnt/usb/Backup/lms/${fname}_${now}.${ext}"
}


function doBackups() {
    pcp
}


main $@
