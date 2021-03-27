#!/usr/bin/env bash

# Master script for backing up anything to do with restic

function backup_small_files {
    BACKUP_PATHS="/var/lib/unifi/backup/autobackup /etc/pihole /mnt/usb/Backup/media/beets-db"
    #BACKUP_EXCLUDES="--exclude-file /home/rupert/.restic_excludes --exclude-if-present .exclude_from_backup"
    BACKUP_EXCLUDES=""
    RETENTION_DAYS=7
    RETENTION_WEEKS=5
    RETENTION_MONTHS=12
    RETENTION_YEARS=3
    RESTIC_REPOSITORY=/mnt/usb/Backup/restic/small-files
    RESTIC_PASSWORD_FILE=/home/restic/.resticpw
    
    echo "Backing up small files"
    restic backup --verbose --tag systemd.timer $BACKUP_EXCLUDES $BACKUP_PATHS
    echo "Forgetting old small files"
    restic forget --verbose --tag systemd.timer --group-by "paths,tags" --keep-daily $RETENTION_DAYS --k
}


function backup_media {
    BACKUP_PATHS="/mnt/usb/Backup/media/beets-db /mnt/usb/Backup/media/lossless /mnt/usb/Backup/media/music /mnt/usb/Backup/media/vinyl"
    #BACKUP_EXCLUDES="--exclude-file /home/rupert/.restic_excludes --exclude-if-present .exclude_from_backup"
    BACKUP_EXCLUDES=""
    RETENTION_DAYS=30
    RETENTION_WEEKS=5
    RETENTION_MONTHS=12
    RETENTION_YEARS=3
    RESTIC_REPOSITORY=/mnt/usb/Backup/restic/media
    RESTIC_PASSWORD_FILE=/home/restic/.resticmediapw
    
    echo "Backing up media"
    restic backup --verbose --tag systemd.timer $BACKUP_EXCLUDES $BACKUP_PATHS
    echo "Forgetting old media"
    restic forget --verbose --tag systemd.timer --group-by "paths,tags" --keep-daily $RETENTION_DAYS --k
}


function main {
    backup_small_files

    backup_media
}

main $@
