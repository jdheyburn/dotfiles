#!/usr/bin/env bash

# Master script for backing up anything to do with restic

function do_restic() {
    local mode=$1
    local target=$2

    if [ $mode == "backup" ]; then
        echo "Backing up $target"
        restic backup --verbose --tag systemd.timer $BACKUP_EXCLUDES $BACKUP_PATHS
        echo "Forgetting old $target"
        restic forget --verbose --tag systemd.timer --group-by "paths,tags" --keep-daily $RETENTION_DAYS --keep-weekly $RETENTION_WEEKS --keep-monthly $RETENTION_MONTHS --keep-yearly $RETENTION_YEARS
    elif [ $mode == "prune" ]; then
        echo "pruning $target"
        restic --verbose prune
    fi
}

function small_files() {
    export BACKUP_PATHS="/var/lib/unifi/backup/autobackup /etc/pihole /mnt/usb/Backup/lms"
    export BACKUP_EXCLUDES=""
    export RETENTION_DAYS=7
    export RETENTION_WEEKS=5
    export RETENTION_MONTHS=12
    export RETENTION_YEARS=3
    export RESTIC_REPOSITORY=/mnt/usb/Backup/restic/small-files
    export RESTIC_PASSWORD_FILE=/home/restic/.resticpw

    local mode=$1

    do_restic $mode "small files"
}

function media() {
    export BACKUP_PATHS="/mnt/usb/Backup/media/beets-db /mnt/usb/Backup/media/lossless /mnt/usb/Backup/media/music /mnt/usb/Backup/media/vinyl"
    export BACKUP_EXCLUDES=""
    export RETENTION_DAYS=30
    export RETENTION_WEEKS=0
    export RETENTION_MONTHS=0
    export RETENTION_YEARS=0
    export RESTIC_REPOSITORY=/mnt/usb/Backup/restic/media
    export RESTIC_PASSWORD_FILE=/home/restic/.resticmediapw

    local mode=$1

    do_restic $mode "media"
}

function main() {

    mode=$1

    if [ $mode == "backup" ]; then
        /home/jdheyburn/dotfiles/restic/pull-backups.sh
    fi

    small_files $mode
    media $mode
}

main $@
