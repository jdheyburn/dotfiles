#!/usr/bin/env bash

# Master script for backing up all rclone stuff to various clouds

function main() {

    if [ "$BACKUP_TYPE" = "media" ]; then

    echo "rcloning beets-db -> gdrive:media/beets-db"
    $RCLONE -v sync /mnt/usb/Backup/media/beets-db gdrive:media/beets-db --config=$RCLONE_CONFIG

    echo "rcloning music -> gdrive:media/music"
    $RCLONE -v sync /mnt/usb/Backup/media/music gdrive:media/music --config=$RCLONE_CONFIG 

    echo "rcloning lossless -> gdrive:media/lossless"
    $RCLONE -v sync /mnt/usb/Backup/media/lossless gdrive:media/lossless --config=$RCLONE_CONFIG

    echo "rcloning vinyl -> gdrive:media/vinyl"
    $RCLONE -v sync /mnt/usb/Backup/media/vinyl gdrive:media/vinyl --config=$RCLONE_CONFIG

    echo "rcloning restic/media -> b2:restic/media"
    $RCLONE -v sync /mnt/usb/Backup/restic/media b2:iifu8Noi-backups/restic/media --config=$RCLONE_CONFIG

    elif [ "$BACKUP_TYPE" = "small-files" ]; then
        echo "rcloning restic/small-files -> b2:restic/small-files"
        $RCLONE -v sync /mnt/usb/Backup/restic/small-files b2:iifu8Noi-backups/restic/small-files --config=$RCLONE_CONFIG
    fi

    echo "Done rcloning"
}

main $@
