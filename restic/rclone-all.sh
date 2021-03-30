#!/usr/bin/env bash

# Master script for backing up all rclone stuff to various clouds

RCLONE_CONFIG=/home/jdheyburn/.config/rclone/rclone.conf

function main() {

    echo "rcloning beets-db -> gdrive:media/beets-db"
    rclone -v sync /mnt/usb/Backup/media/beets-db gdrive:media/beets-db --config=${RCLONE_CONFIG}

    echo "rcloning music -> gdrive:media/music"
    rclone -v sync /mnt/usb/Backup/media/music gdrive:media/music --config=${RCLONE_CONFIG}

    echo "rcloning lossless -> gdrive:media/lossless"
    rclone -v sync /mnt/usb/Backup/media/lossless gdrive:media/lossless --config=${RCLONE_CONFIG}

    echo "rcloning vinyl -> gdrive:media/vinyl"
    rclone -v sync /mnt/usb/Backup/media/vinyl gdrive:media/vinyl --config=${RCLONE_CONFIG}

    echo "rcloning restic -> b2:restic"
    rclone -v sync /mnt/usb/Backup/restic b2:ueNufo6p-restic-backups/restic/ --config=${RCLONE_CONFIG}

    echo "Done rcloning"
}

main $@
