#!/usr/bin/env bash

# Master script for backing up anything to do with restic

function backup_small_files {
    export BACKUP_PATHS="/var/lib/unifi/backup/autobackup /etc/pihole /mnt/usb/Backup/media/beets-db"
    #BACKUP_EXCLUDES="--exclude-file /home/rupert/.restic_excludes --exclude-if-present .exclude_from_backup"
    export BACKUP_EXCLUDES=""
    export RETENTION_DAYS=7
    export RETENTION_WEEKS=5
    export RETENTION_MONTHS=12
    export RETENTION_YEARS=3
    export RESTIC_REPOSITORY=/mnt/usb/Backup/restic/small-files
    export RESTIC_PASSWORD_FILE=/home/restic/.resticpw
    
    echo "Backing up small files"
    restic backup --verbose --tag systemd.timer $BACKUP_EXCLUDES $BACKUP_PATHS
    echo "Forgetting old small files"
    restic forget --verbose --tag systemd.timer --group-by "paths,tags" --keep-daily $RETENTION_DAYS --keep-weekly $RETENTION_WEEKS --keep-monthly $RETENTION_MONTHS --keep-yearly $RETENTION_YEARS
}


function backup_media {
    export BACKUP_PATHS="/mnt/usb/Backup/media/beets-db /mnt/usb/Backup/media/lossless /mnt/usb/Backup/media/music /mnt/usb/Backup/media/vinyl"
    #BACKUP_EXCLUDES="--exclude-file /home/rupert/.restic_excludes --exclude-if-present .exclude_from_backup"
    export BACKUP_EXCLUDES=""
    export RETENTION_DAYS=30
    export RETENTION_WEEKS=5
    export RETENTION_MONTHS=12
    export RETENTION_YEARS=3
    export RESTIC_REPOSITORY=/mnt/usb/Backup/restic/media
    export RESTIC_PASSWORD_FILE=/home/restic/.resticmediapw
    
    echo "Backing up media"
    restic backup --verbose --tag systemd.timer $BACKUP_EXCLUDES $BACKUP_PATHS
    echo "Forgetting old media"
    restic forget --verbose --tag systemd.timer --group-by "paths,tags" --keep-daily $RETENTION_DAYS --keep-weekly $RETENTION_WEEKS --keep-monthly $RETENTION_MONTHS --keep-yearly $RETENTION_YEARS
}


function main {
    backup_small_files

    backup_media
}

main $@
